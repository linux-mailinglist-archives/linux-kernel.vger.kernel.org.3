Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB5507D27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiDSXVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352081AbiDSXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:21:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51253AA66
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:18:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JKpGGq019298;
        Tue, 19 Apr 2022 23:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MGqK5ttiizLNtyDdXKv+Ib5/GWbDDtD+L+9Mt35wPoA=;
 b=kmqaNLzfg4kNLrcYsmNldhvOA1CH0zuhoPZtD41nEcZaHIGV702D2+KtAJAwbgnSxrt+
 FfVqSX8QHTanv4MsQtDo/GNe3fIyaaFVMixxtxWiGlyj6amw4ruOG0bdPGyls6eK7nL+
 wGAQQjmKNUp6dkIrK2ZZVZgWg+bR3NHOWRMfN+aoIHTeEv9Yrnq5FMsjWXKS3NTOht2O
 AYhnNtf5kq0s7nV12ZTFXdOln75ibm9gFOuhH4m11uwdH5/sR/Q+Fk1IFFoS+NvU5+0x
 BhnwIabc6H7/9r4Z1iIIYD7YIRcDRFQSk3pUrf5/qyU+JO0W89lNdGniYkG5xVDq81FE wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cqb8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 23:18:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JNGcgT023423;
        Tue, 19 Apr 2022 23:18:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm83ttsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 23:18:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9EUHoBBKy5OdM4cMduRNC84F7hp6Di1hLaQ0ji5Ubd+kkciZ8Zvq177IUc6lbaYwUZDrSHjYwa4G+FWuls5yYUZaoKzuh++6kIXUMGBPV5PJGQMGAi/KWq9TwhiB9ljY50sJB/47343JHRDrGXd7ddHLgF/qekhFnRqH2137FPjZJn/hVuyr70M9+EWXrnk59NF3USKoec1zKD5WYtHhnT+u3YWzTlpNzGOMyfhCkOB0xfuyCZsQPceV0dnhDeMO2oc+IXqVXRFGmqpVahkv6RIqiN1+DKXz9hcSyg6bH6Ly5BIJoDrk+amLQ2dLfAdUIno2jgWPuMP9FTFI1AedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGqK5ttiizLNtyDdXKv+Ib5/GWbDDtD+L+9Mt35wPoA=;
 b=WmdLdKBKdZj4XqdxWu5238lOesuPIubC/og8xk0WgrDUBnWuV6oB/sqvMgkcUXcKt/F6ztLCzNMiGa7QRzXeE2LeqGBVQDmGvzYK9puGQ7vETPHRW1vJgAr54S8L5/JKH/ylgyZBQdeLqsUQQDC3EUy82Ko34GQulB/S9B2Q8a79Zjo5l3kGewyK6IsFmT6E4woUAqA1xs2WaTI75hmT68PCDJEHU+h8Aa7oo9mRd5Lt8hS13pb0zPeR+/ab5sz8nvM2eT9KesZRiWyGDVJLQTiOOYsJ7R5TCaOKw/4NLVT44Tn4MMAY7gSpytkd+Pu90ovjrpEiE2YsHjorL5ZlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGqK5ttiizLNtyDdXKv+Ib5/GWbDDtD+L+9Mt35wPoA=;
 b=EH9UwrYYtwvbf2OA2NZrMuz4GPSRjIRDFqrnOpsAfFeV3HSIIfnZ5u0/BhMXEdwqPEBPy7S24CmCaOZuIpOnl99Kpm0lCHgSujcfmDeqBN18nJjXC7WB4tV5TCYjEkjU8sRnYIUlxHohC4sKG+QWTAL0RZdr/8za7U6bfWN7kjY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3218.namprd10.prod.outlook.com (2603:10b6:408:c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 23:18:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 23:18:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAADJWgIAABQ6AgAAimYCAAMbngIABK32AgAA0VgCAALsBgIAARfaAgAR5x4CAAGa4AIAAFiQA
Date:   Tue, 19 Apr 2022 23:18:02 +0000
Message-ID: <20220419231748.omnhkl43vl5ep2j5@revolver>
References: <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
 <20220414171521.bgdvrirumd4atjhs@revolver>
 <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
 <20220416151923.ig5zavuptjsufm3d@revolver>
 <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
 <20220419155055.qf52xpcftqb3r5nj@revolver>
 <CAOUHufbX_aq+aHf-EVKFLN_jw6hXJ5vtKpG0jskD6uXVKB406w@mail.gmail.com>
In-Reply-To: <CAOUHufbX_aq+aHf-EVKFLN_jw6hXJ5vtKpG0jskD6uXVKB406w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 003d0da9-cf32-4bd9-8a7c-08da225ad9da
x-ms-traffictypediagnostic: BN8PR10MB3218:EE_
x-microsoft-antispam-prvs: <BN8PR10MB32189C96F247662520167976FDF29@BN8PR10MB3218.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfaDXFyJ4S3m7b3efcvMD0EVhJNTbWpsNiH+hH5Qpx7jLY+9v6WsdU/RXsJaQPtsz5Z0HzX6BMPOmpswgWZm3lhvPV6dRY/ImUxXxK2wG45rF+i7eExx7QJ24Gp7gkmGz8osA9dA80Um7ayRUBPGlAC5Hl9YU18IyWsUiAkl62qkKGg1Ewf243DPJKzwxjI+URvhKIU3r0dl8ICF565mIK7E8NY/r+GN+/FU4QL3yZEjx6u+WQibBgQxDkuPEGqlkUz0IXvF6RijJJKfoTIFFmDgeRjL82pGdyY+KFd/EKB7/DPfAMTJGZ0cyoeO/LrojPA/xvQNJbBwRKcQWx6JeGJON4jNy+WCRgitE1boTw+uX6LwXZdqX3M2yTNUYZPjSNbwC/vkCY3akY9m7hpciYNDNIZjaJ+YxoXiJPADVCCijQjEPSAE1I74SeMmsSWBKTumyMVneSaeOqyahphiwM9/YeITwLY26DWAo6dk7gXIZVy8LllVv8f1SBS3k+3nR782flnrz+e1MPBrWxygmi2pFG8OEqx7Ph8t3Qa0cf+hclcQVbKkNMGLTGSvTp+HPr9FZOgczS+SA3pw+s8dos5P+hIoJT6rZKxwMMTQ49S09jkXmUuiOhWqQAKcLNyhZPoMUQGSpLP7eIPwsoy/XPIHbw2YPy3Ioab3goMU5CwUKY/txoKmwezqI7P91s2LcGH/hsu93grqFCEbn2Qg7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(76116006)(2906002)(91956017)(66446008)(66476007)(508600001)(316002)(33716001)(6916009)(6486002)(66556008)(66946007)(4326008)(8676002)(86362001)(71200400001)(54906003)(64756008)(53546011)(6512007)(9686003)(6506007)(186003)(26005)(8936002)(83380400001)(38070700005)(5660300002)(38100700002)(44832011)(1076003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tL6iY2wQuoU/TnYUZ0qwqgzws3QUj46hOSV2wevy1f3emF0PBn+k2//M+jKZ?=
 =?us-ascii?Q?ZDCZehfQLOvZ95rT4Kvge2OxjHsCioO86MDxA7q6WgaPLeHGemmJMq9yCq5W?=
 =?us-ascii?Q?7H4fXtIWjgcOHjX3z6sivkn7Aw8F4ttiyUzo8NcWg4xnN81aGgvnrFoT/IU0?=
 =?us-ascii?Q?SGwAlNsIVDN317xQbgtQFWy2LZTQWsW3BBFrYMv45JJxVc11p7pjTJ53tGet?=
 =?us-ascii?Q?PYLswI2ROweaatEmOczxRyNdaD4EY+WE5903JkJo5gYPJEJM1H65/RoYYvBe?=
 =?us-ascii?Q?Cd58OxHczMPV1PuMvW3F7KHnG7uGXLzvBRn8Y1t7CoMU3q3NJvKPKxYxI8ZN?=
 =?us-ascii?Q?EkIUyye6Q37p7sDZoJZ2QNjmqoqrQe/UV7Z8I62KsQBll4ajUbhY+w7EbIBF?=
 =?us-ascii?Q?MVxLFizCtYlijM1IM5AmxduSMvtn1SYmCBM9jz1SR98nl7Z0k1Yl1EhzF0Ou?=
 =?us-ascii?Q?dbF0A9pzUv1cLsjehOmcNNsqv5fAFqAHbhKBPIyK0DirwMineYpCdA4qm5hW?=
 =?us-ascii?Q?96GpkKcyetU5aGdtvdrb91DOqHcaFNRePsdXS+gu1ZhM5zOcoF8JzatLla2+?=
 =?us-ascii?Q?fBoqeiB9mIsQjf1iGmrWlFby7UuPayl0soy6bwv1OBytXCjEIT/bw1ZpuPzE?=
 =?us-ascii?Q?7BaLPI5JewQBzVq+wbj8ufo12bb2W0k7CV8d5YefoE81iquWYpCcjA3PAFw5?=
 =?us-ascii?Q?T/mS7uE8SohOsRLH3MUbrYHfx+DSVDy7zJjT03DASqO0P9r5LWLhD1EZIMP0?=
 =?us-ascii?Q?vle8q90Hi4Gop1SOLbNuxxisnDaUF9HaNyzuxwsTH4kwdMWbkwuTxZLCZbQ4?=
 =?us-ascii?Q?4mBuQ74WqC7M68P+cs7tW7a3lJiaQLp1VPrdaf/vqkHWvqLItLj30k9a2rbV?=
 =?us-ascii?Q?6uYN9qnb9f14QKkZGL1fV16HIFdnb1Wg/brxS2weEYHwv620IBr24+Lvz5zO?=
 =?us-ascii?Q?35chltLncXo5IkQ4B8Qtfo1Zlm9qN96MCXJn1dK2lHSA04pC5T9vyg+3irc3?=
 =?us-ascii?Q?SYf8SiKPuMsUJVMtfik2jWBaLv7Nj4d7bKPitGPNH7aNmT76Mr7OFyZI9sL6?=
 =?us-ascii?Q?MEJUepE1eTqORIwBbfiH763c1mQcksp4kpWB/Omy21y7LVYJQo/9QswGubzP?=
 =?us-ascii?Q?VBSe2KZAVgf1aiiLx2xytPSUv+vrMvVlZu6YikeJP69Qkth2mH9TchRKs4ZL?=
 =?us-ascii?Q?rL26ESwQRHREYWueKsgZ7LAMGuaDgivqRCDrxq5Sbfkz7AuCm2KeShS94io0?=
 =?us-ascii?Q?9H2SdGeKZuVLQEVEEk0rCQolBfBefhf5EfVISOOhsdIKKlPo1WdKiyBpZw6x?=
 =?us-ascii?Q?s8JKPWbCPqlcRMEQQSiAAetfs//VU2H6XawDtyKuV/HMWR67AhwARV4rEGNn?=
 =?us-ascii?Q?wM5jlh1dBf5Fc6U5gW582RLLqXcv9te9Ztr3tGm74+a2e/YAOieILGoBbFGG?=
 =?us-ascii?Q?Bk2up+QUwlGFhhgi9K5+7TsVKI96OtbiwUI1HonqYid1GRrg/b1XURcGWtKB?=
 =?us-ascii?Q?wFqb3Y6aH+FIBoOIt9RQg8KojxLvdctvLf2FWX7zNJpWkzAHvofKjYZDsE9E?=
 =?us-ascii?Q?/XaIvoqk4PwYnVP0XzrgEEedInGtPQq3qrN4qCTFrrwKh5GVF4AI7ecLADR6?=
 =?us-ascii?Q?t+gnqIF2FjR42x7tsGazn59VKxqAVzQ++Zmk5CXb1OZBfGypda/hSAemLA/5?=
 =?us-ascii?Q?JTrwP5pewJUsthJ/1OgTi1mlV/tL827paep6GeUS2NFDVrqkvDxyaZbZC/Ig?=
 =?us-ascii?Q?kGb2m9YnBj7WzrJLp/lIdUTw+TCxmAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9477DC8A8DF00945A0802C2BB7E46E64@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003d0da9-cf32-4bd9-8a7c-08da225ad9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 23:18:02.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fHdUH6F/s+9wNQrtT8TJY/a55sQjPB1CgUPiaJJ7br+PyK3h7lOdNq8js2L52LiWRWfeo0bLCSxvRzDZU5QEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3218
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190127
X-Proofpoint-GUID: GRLgCp0Ebu9dvQCMVx9RMdfcvDDjphbi
X-Proofpoint-ORIG-GUID: GRLgCp0Ebu9dvQCMVx9RMdfcvDDjphbi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220419 17:59]:
> On Tue, Apr 19, 2022 at 9:51 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Yu Zhao <yuzhao@google.com> [220416 15:30]:
> > > On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@oracle.com=
> wrote:
> > > >
> > >
> > > <snipped>
> > >
> > > > How did you hit this issue?  Just on boot?
> > >
> > > I was hoping this is known to you or you have something I can verify =
for you.
> >
> >
> > Thanks, yes.  I believe that both crashes are the same root cause.  The
> > cause is that I was not cleaning up after the kmem bulk allocation
> > failure on my side.  Please test with this patch.
>=20
> Thanks. I applied this patch and hit a LOCKDEP and then a BUG_ON:
>=20
>   lib/maple_tree.c:847 suspicious rcu_dereference_protected() usage!
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x6c/0x9a
>    dump_stack+0x10/0x12
>    lockdep_rcu_suspicious+0x12c/0x140
>    __mt_destroy+0x96/0xd0
>    exit_mmap+0x2a0/0x360
>    __mmput+0x34/0x100
>    mmput+0x2f/0x40
>    free_bprm+0x64/0xe0
>    kernel_execve+0x129/0x330
>    call_usermodehelper_exec_async+0xd8/0x130
>    ? proc_cap_handler+0x210/0x210
>    ret_from_fork+0x1f/0x30
>    </TASK>

Thanks - I'm not sure how this got through, but this should fix it.

This should be added to 4236a642ad185 to avoid the LOCKDEP issue.

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3163,9 +3163,9 @@ void exit_mmap(struct mm_struct *mm)
=20
        BUG_ON(count !=3D mm->map_count);
=20
-       mmap_write_unlock(mm);
        trace_exit_mmap(mm);
        __mt_destroy(&mm->mm_mt);
+       mmap_write_unlock(mm);
        vm_unacct_memory(nr_accounted);
 }

>=20
>   BUG: unable to handle page fault for address: ffffa6072aff0060
>   RIP: 0010:mab_calc_split+0x103/0x1a0
>   Code: 29 c1 8b 86 64 02 00 00 0f b6 80 dc 7d a7 96 39 c1 7e 05 83 c3
> 01 eb 06 81 c3 ff 00 00 00 0f b6 c3 45 84 d2 74 3f 41 0f b6 ca <48> 83
> bc ce 10 01 00 00 00 75 2d 41 83 c0 ff 41 39 c8 7e 20 0f b6
>   RSP: 0018:ffffa6072afef6d0 EFLAGS: 00010286
>   RAX: 0000000000000054 RBX: 0000000000000154 RCX: 00000000000000aa
>   RDX: ffffa6072afef83f RSI: ffffa6072afefa00 RDI: ffffa6072afefe80
>   RBP: ffffa6072afef6e0 R08: 0000000000000010 R09: 00000000000000ff
>   R10: 00000000000000aa R11: 0000000000000001 R12: 00000000000000ff
>   R13: ffffa6072afefa00 R14: ffffa6072afef9c0 R15: 0000000000000008
>   FS:  0000000001d75340(0000) GS:ffff8a56bf980000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffa6072aff0060 CR3: 00000004986ca002 CR4: 00000000001706e0
>   Call Trace:
>    <TASK>
>    mas_spanning_rebalance+0x416/0x2060
>    mas_wr_store_entry+0xa6d/0xa80
>    mas_store_gfp+0xf6/0x170
>    do_mas_align_munmap+0x32b/0x5c0
>    do_mas_munmap+0xf3/0x110
>    __vm_munmap+0xd4/0x180
>    __x64_sys_munmap+0x1b/0x20
>    do_syscall_64+0x44/0xa0
>=20
> $ ./scripts/faddr2line vmlinux mab_calc_split+0x103
> mab_calc_split+0x103/0x1a0:
> mab_no_null_split at lib/maple_tree.c:1787
> (inlined by) mab_calc_split at lib/maple_tree.c:1866

1787 is "if (!b_node->slot[split]) {"  Does this line up with your code?
How did you trigger this?
