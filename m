Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2999E54E954
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377712AbiFPS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiFPS1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:27:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD851E69
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:27:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GG668m029754;
        Thu, 16 Jun 2022 18:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dIAGpVWoRno8WdN9m3Tc2YMuOb9TC3W4UT2izi7rHQ0=;
 b=MVUm7lsdY9q/omZghk4o80MBAAKR/8fHbAuNlk4H7v8/gCuBo6mTZp0bUyZb4N5iNXNn
 PjxPs4R5YVJ0OtdPp0caz9Tvfji7tI63+goq3oJkVVfYuNNPztlnmH1BeqgLVo6XJzb3
 7xzul9mt0Ipoch05LEYvoRvwHLVTZ+r2qFjE30FNuweTGv2sUIFm6QbfUfmjAo1J2cTA
 724oo2YsSs6KHs4ypIGT4GlQHSH7UbbD0Trko35VbK7TRipHrvkKphC6X4af4DLbioKH
 PkGOubx4Uf+ut+OLjMUDjWal/YU2yc090d0Dpn0+tfu7kEfOlORbva1cp7pm0DCqWA/q GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9kt2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:26:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GICGjL030183;
        Thu, 16 Jun 2022 18:26:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq2ph0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:26:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC8mgTStDNTSGxn/UmFpgVy4SiY2y5sQp6VpX/W7JwP7XZKbqtvhpqfPXrhDrZoyTx2nUwO+KMoxSgC1N+DP2QfVyxnT4RZY83ldChD4BW2TRdNRM0o6wIRezjPrn0NlbZbP9v+OkIkfDOOiIjdIjxqX5qncEW13QEZoklksphwC3sI0FceuET0lWyLJqw6DrXLcy2czoy37O8niO1eXDJaucV6426+mKyrtA0qiFfO/C6FleoxDjV6BTusGxKGSDnjFQ4thPqrBMM6LxPPqh5SR2jXxjGVfUEwGJpTyitaIPaGljgDCE1u2U6wVHs0aOZ5tyz04KeHk/vcZNjY92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIAGpVWoRno8WdN9m3Tc2YMuOb9TC3W4UT2izi7rHQ0=;
 b=EAMpYLV2sB01K71P873YaEeDJuUr8Bq28T89HJLcwcxovNQpk1YOEgEpSgSsZG6CbITOeE7bnt6yMlVoXH+CI++Bd5/o1yDEsMBGtS/k0BK0+6uQfl/owgJzDSy7LxrpRnt+Wu9oWpCaKKr4qRfmtbCtrEE1Chr94G9DSKBvQB09eQnbS8woIn60l9SnrwhxFIoRxRotaPZISzgQtBoBeELP7pCwm6mC7Ps7zFOqqxPl0nicZ0PVK0g05K2yb9zxLkArbPCI5JkX+JMW2GbIOluh5uWAmTUw/7lxsK7cusSc9tvWZyFEpeFNwooDFwX3k3dpSCPDERXikxsT/VXTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIAGpVWoRno8WdN9m3Tc2YMuOb9TC3W4UT2izi7rHQ0=;
 b=KMGxxQL63x/JvVHRy+PyyFkUv/AJARNS4sqMFr2WduuZvmT8W0w31bf9TMPlByAbRSkqgAU8nu7m6d9yxWXtLoZGLMQEZJ8yoQQmoIt4CI2mKoVcYLxK5SdvUhO8ASU3JQxR8sBF8hyhr6+KbJqRLM95jUzrOKuYuggg7a8YTuE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1484.namprd10.prod.outlook.com (2603:10b6:3:12::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Thu, 16 Jun
 2022 18:26:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.023; Thu, 16 Jun 2022
 18:26:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+q1Cfd0AgABF+YCAAAXagIAIFpmAgAAbWQCABc0jAIAAPjyAgAANPQCAAALVAIAAJMOAgABMQwCAAAJqAIAAEAiAgAAB9ACAAC1XgIAAAvwAgADRy4A=
Date:   Thu, 16 Jun 2022 18:26:56 +0000
Message-ID: <20220616182647.hlwadwzvlojbjlj5@revolver>
References: <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver>
 <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
 <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
 <20220616014956.6jgxvbzh4ld3c32q@revolver>
 <CAOUHufZtq0PDiGXBvLV=POraK-4dfnQ9UNmsafHhJmzxAhzrfw@mail.gmail.com>
 <20220616025557.euz6z5rlh7fqewy2@revolver>
 <CAOUHufb04ej_R32qWgah1Oqds_KpEgL+=d0SysE=pfCM7wovxQ@mail.gmail.com>
 <CAOUHufbNR6NsYX_fd+_6WaiNkewyfWuDN-9KnPBOdxaPTks-8w@mail.gmail.com>
 <CAOUHufYd=H6un8=MHs0GE7oOjqMt6WNndEcrTJbJX_gmOHWbgQ@mail.gmail.com>
In-Reply-To: <CAOUHufYd=H6un8=MHs0GE7oOjqMt6WNndEcrTJbJX_gmOHWbgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd49369c-74f7-40d3-e15c-08da4fc5cb4b
x-ms-traffictypediagnostic: DM5PR10MB1484:EE_
x-microsoft-antispam-prvs: <DM5PR10MB14844319CD11C1307AE8ACB0FDAC9@DM5PR10MB1484.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYHq4d5N0FlQRviV/67bWl1cxebsjA7kKN9rR3KndhacdrMvEmvhkNzk7/hPc64IBD4zWEqG+zpMCiyxaBxrIyMXa1eoQoNk0lcdESe9vIuVb/T6MbmoJMDErIPOHJHXBHdrTFTrUyMowd+XdWZS05I9RHHYu0IGS3sDaUakOYpIZXCkuKGAuPoYBZp5zIb+1rlXwPWvib7sF8oJjUKyDBgVTJRhML5fpKAL9es6ZDwY4w8Qj9H+j/lbnIXjjJKJAp+j2124ctc/PpufgJEcSdNcD+q3X5pWfKIfoNuuSQDe1Q7oU/mwzcHkPdO0ShQU3jadpwioywMWdGPAjhZr4uaUd0MHUtsYd8igl8UijjaZK8acz+tImnMu/l8TxgYgAuUa9NHQdK1KI7rT6qjwiV5vGBn5Sb4kyooGNjVPkRDXbm1rUnMZ5iTI5jU/h9YIKRCKuaqEK1KLGr9VdhAkNbE+OV1l2117AB1EvXcyBoB9I8EE8RexFjf0Nmo71zZ1gH9IeVZv+ra+DzW4M+Of8RakDe9fXRXQsX+hTMgk00LelMwehdDNctf6VqhJ/UxfIdmJw1bEndqzD3/ikkLhYUlujWkTaFQChCemLHduJt2uew/0+LJTu8G82gH4K5DeO2dv8Aah2tB+9t+pnytHsMDrDvuGXvSJFDPqVe0BBUF7KYyvyg/QAtDYfR4ymIfWFgi/M1AgxO9kQrAUm/BNmwTVw6UkiCLGhf1qD84FcTi1TfJhiKaAn6gOOWJMA3deT4owQ9PCRMcoJ5Le0d0pbvoWEAX6V6cBPaIBzI/JQQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(38070700005)(508600001)(8936002)(966005)(6486002)(71200400001)(64756008)(5660300002)(4326008)(83380400001)(6506007)(86362001)(53546011)(9686003)(26005)(6512007)(2906002)(186003)(8676002)(1076003)(316002)(33716001)(44832011)(54906003)(6916009)(91956017)(66476007)(122000001)(76116006)(66946007)(66556008)(66446008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2B/pTN8DJfpicjkxG5rkE2xIWWwBIj+loAEPIDiKHfIYscvNM4e8bJxF79H4?=
 =?us-ascii?Q?uabreqyJlJl4hQmLc+ZUZN1iFyoRhlx++57TGcKpzRQITNyPGT6VSMdHgk5w?=
 =?us-ascii?Q?0aLN+1pqYGJKSz78Crndt0Mf2/xR7vbazw4CL3LLcYQQLbjn+UeXY09Mxwls?=
 =?us-ascii?Q?zimDvKThMdIS3VXc3kvubqnsskPuCgjKVyq6eHwNNxb1qgXLGUZwoz1FBOz1?=
 =?us-ascii?Q?ioPmf/pl/N6uUxBE62bXI0z7+9XqFnKIs31h+qbULEG/S6vUVe1lRlY8acK+?=
 =?us-ascii?Q?EwzeBW4dfL1bKbenZiKfx+cvE+1RfYiQcx8Y+Z5GcPjSAHF/v5LhudfV9aEh?=
 =?us-ascii?Q?xfUhI22G7KtQM23C+wEjs3qoKbjNnIGFppP5HP1HHO2Cl0vzf6xsfd4/WwpN?=
 =?us-ascii?Q?f6qlARmLSEAtj6xhONq8meLYjI5SxreEXK9N/bDcAaRXEYniQ3zpDCpE4i/z?=
 =?us-ascii?Q?XQqv7PmV6eZm41TTX1MCSNb++HrS//bcE9O3yKlniZGSxSg7g8m/ByWekpTK?=
 =?us-ascii?Q?CxGhLm7rpk0rFhWNhFRQU+G4F9Gsm7b2K9Sx8XtonsNu75O+1i8vrW+BLuTO?=
 =?us-ascii?Q?sE6whVepvcnnmVAbX3cB57AFhJW+2CJmKUv2NM34pS6QijNcwBNrqYoUuUr1?=
 =?us-ascii?Q?qUVnlAvK2ezyq/OfwBi7BVuJai2l8kZQ/NP5/Nef8evEZFTP7Q/Hc9te8RPU?=
 =?us-ascii?Q?+L4fE7p75UstowzqAxyvoPjs7/MLJ+z4fYJqMoBxLGDsk2Ra9ijplRQHGXLY?=
 =?us-ascii?Q?Kot7o30ac5Ldw3edgLm/ZENg4JU+39lqzFyOEdLcuEg3w8lIyG6GA/7AewTO?=
 =?us-ascii?Q?xtogTZCWlmWtwq235LODSSm8/IiqJEMhBEHfpv08/PvdBCi3elLKCByGyaI7?=
 =?us-ascii?Q?BC3TzRaHfnbpWta2ooiSykSoAug3csSChYToWR6ExT20Op3MmfXSRHVp4ixP?=
 =?us-ascii?Q?xy/cy3j1I+aFuC7oRDUBcHa6wl9qifTmEOKvfkVpoBZuvXEV1FnQ0HU6arGS?=
 =?us-ascii?Q?19el83RZDzW/aH5k1vbWFY4nijeFWYKogD8cXlkRRIZTBvHxf3NiXgeo3Jfk?=
 =?us-ascii?Q?txmdy5/U4ZJOxXjiqkap2eFuodncZsS97RPbuCedm/82r4zdocFGD9ODZayn?=
 =?us-ascii?Q?eNAQm+fRlSkQ1alm4C6XDdcFKLaTGsWJsn4lN06nrOyG5AxB81uQXUzOPxV8?=
 =?us-ascii?Q?kpgCtK7rde6tjqZxbjG0WCqcAyCW4yOYlGBlhJjjePp2I8i/bX7wt3tnEmdx?=
 =?us-ascii?Q?P4mXx+3lPBGDfPQFEb0KTiGd0xpTecQA3bDxrosBWb+F8XiioSD7WdoZpXIT?=
 =?us-ascii?Q?vulNMdRlqa3G2BI71gxfwBt9VR5NptERhbL/ljMEdtQd6OTvkCX8DVbymqYd?=
 =?us-ascii?Q?1phXqxUIsrKmhxLCVtCyW7arvI/L3QX8D27YqJxLJwrKiPpv3dEKs1/IjzUh?=
 =?us-ascii?Q?KNQuaxHK7WWmvWR3WoBjwwEUt7IPBp4x1BLaX2ziTtUM2SuQfGTq3zAVgZ0P?=
 =?us-ascii?Q?o/LaglrSPB+45rSZZ1tDPmLUX4sGd/wUHEv8Vn9u/aGemHGqX3LlRpffZ9L7?=
 =?us-ascii?Q?xAY9tJP+P/fP5mMdhX4c43AhhGzqlwfwqCL3P1PbmXsvmoFegMY5KCvH21je?=
 =?us-ascii?Q?jWMqlOgV2mGS7UGpfdCWzAkblAAy/Y0h6gx2/BKa7g/q86G/wjPeEjVvHUxu?=
 =?us-ascii?Q?fwGhitrrVjUnpVmJp4HBDlV3O0tYDByQM0pSuyYUdLahcqhrHnbGSFw3xPLf?=
 =?us-ascii?Q?qOeti3zDq8C/5PnUNSnj46Tj45FvzLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1568B2A876D0E548BE43C7020275387C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd49369c-74f7-40d3-e15c-08da4fc5cb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 18:26:56.3933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuhVOfkL9DYytP9VL4EWgqSEKXZxv6cukIBY7+ayN2KZs4zCl6USoIPbbbuMu6L3xSSgMXLx5HWFS0FY+4LT8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1484
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_14:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=666
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160074
X-Proofpoint-ORIG-GUID: iho1wZBhQ4UiwkU-ukjWoGHkvLCnj9-m
X-Proofpoint-GUID: iho1wZBhQ4UiwkU-ukjWoGHkvLCnj9-m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220616 01:56]:
> On Wed, Jun 15, 2022 at 11:45 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Wed, Jun 15, 2022 at 9:02 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Wed, Jun 15, 2022 at 8:56 PM Liam Howlett <liam.howlett@oracle.com=
> wrote:
> > > >
> > > > * Yu Zhao <yuzhao@google.com> [220615 21:59]:
> > > > > On Wed, Jun 15, 2022 at 7:50 PM Liam Howlett <liam.howlett@oracle=
.com> wrote:
> > > > > >
> > > > > > * Yu Zhao <yuzhao@google.com> [220615 17:17]:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > Yes, I used the same parameters with 512GB of RAM, and the =
kernel with
> > > > > > > > KASAN and other debug options.
> > > > > > >
> > > > > > > Sorry, Liam. I got the same crash :(
> > > > > >
> > > > > > Thanks for running this promptly.  I am trying to get my own se=
rver
> > > > > > setup now.
> > > > > >
> > > > > > >
> > > > > > > 9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/mm-ev=
erything)
> > > > > > > 00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for_eac=
h() loop
> > > > > > > 55140693394d maple_tree: Make mas_prealloc() error checking m=
ore generic
> > > > > > > 2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full non-le=
af non-alloc nodes
> > > > > > > 4d4472148ccd maple_tree: Change spanning store to work on lar=
ger trees
> > > > > > > ea36bcc14c00 test_maple_tree: Add tests for preallocations an=
d large
> > > > > > > spanning writes
> > > > > > > 0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked_pag=
e_nr()
> > > > > > >
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > > > > > Write of size 136 at addr ffff88c35a3b9e80 by task stress-ng/=
19303
> > > > > > >
> > > > > > > CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I     =
  5.19.0-smp-DEV #1
> > > > > > > Call Trace:
> > > > > > >  <TASK>
> > > > > > >  dump_stack_lvl+0xc5/0xf4
> > > > > > >  print_address_description+0x7f/0x460
> > > > > > >  print_report+0x10b/0x240
> > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > >  kasan_report+0xe6/0x110
> > > > > > >  ? mast_spanning_rebalance+0x2634/0x29b0
> > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > >  kasan_check_range+0x2ef/0x310
> > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > > > >  memcpy+0x44/0x70
> > > > > > >  mab_mas_cp+0x2d9/0x6c0
> > > > > > >  mas_spanning_rebalance+0x1a3e/0x4f90
> > > > > >
> > > > > > Does this translate to an inline around line 2997?
> > > > > > And then probably around 2808?
> > > > >
> > > > > $ ./scripts/faddr2line vmlinux mab_mas_cp+0x2d9
> > > > > mab_mas_cp+0x2d9/0x6c0:
> > > > > mab_mas_cp at lib/maple_tree.c:1988
> > > > > $ ./scripts/faddr2line vmlinux mas_spanning_rebalance+0x1a3e
> > > > > mas_spanning_rebalance+0x1a3e/0x4f90:
> > > > > mast_cp_to_nodes at lib/maple_tree.c:?
> > > > > (inlined by) mas_spanning_rebalance at lib/maple_tree.c:2997
> > > > > $ ./scripts/faddr2line vmlinux mas_wr_spanning_store+0x16c5
> > > > > mas_wr_spanning_store+0x16c5/0x1b80:
> > > > > mas_wr_spanning_store at lib/maple_tree.c:?
> > > > >
> > > > > No idea why faddr2line didn't work for the last two addresses. GD=
B
> > > > > seems more reliable.
> > > > >
> > > > > (gdb) li *(mab_mas_cp+0x2d9)
> > > > > 0xffffffff8226b049 is in mab_mas_cp (lib/maple_tree.c:1988).
> > > > > (gdb) li *(mas_spanning_rebalance+0x1a3e)
> > > > > 0xffffffff822633ce is in mas_spanning_rebalance (lib/maple_tree.c=
:2801).
> > > > > quit)
> > > > > (gdb) li *(mas_wr_spanning_store+0x16c5)
> > > > > 0xffffffff8225cfb5 is in mas_wr_spanning_store (lib/maple_tree.c:=
4030).
> > > >
> > > >
> > > > Thanks.  I am not having luck recreating it.  I am hitting what loo=
ks
> > > > like an unrelated issue in the unstable mm, "scheduling while atomi=
c".
> > > > I will try the git commit you indicate above.
> > >
> > > Fix here:
> > > https://lore.kernel.org/linux-mm/20220615160446.be1f75fd256d67e57b27a=
9fc@linux-foundation.org/
> >
> > A seemingly new crash on arm64:
> >
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x000000000000000f]
> > Call trace:
> >  __hwasan_check_x2_67043363+0x4/0x34
> >  mas_wr_store_entry+0x178/0x5c0
> >  mas_store+0x88/0xc8
> >  dup_mmap+0x4bc/0x6d8
> >  dup_mm+0x8c/0x17c
> >  copy_mm+0xb0/0x12c
> >  copy_process+0xa44/0x17d4
> >  kernel_clone+0x100/0x2cc
> >  __arm64_sys_clone+0xf4/0x120
> >  el0_svc_common+0xfc/0x1cc
> >  do_el0_svc_compat+0x38/0x5c
> >  el0_svc_compat+0x68/0xf4
> >  el0t_32_sync_handler+0xc0/0xf0
> >  el0t_32_sync+0x190/0x194
> > Code: aa0203e0 d2800441 141e931d 9344dc50 (38706930)
>=20
> And bad rss counters from another arm64 machine:
>=20
> BUG: Bad rss-counter state mm:a6ffff80895ff840 type:MM_ANONPAGES val:4
> Call trace:
>  __mmdrop+0x1f0/0x208
>  __mmput+0x194/0x198
>  mmput+0x5c/0x80
>  exit_mm+0x108/0x190
>  do_exit+0x244/0xc98
>  __arm64_sys_exit_group+0x0/0x30
>  __wake_up_parent+0x0/0x48
>  el0_svc_common+0xfc/0x1cc
>  do_el0_svc_compat+0x38/0x5c
>  el0_svc_compat+0x68/0xf4
>  el0t_32_sync_handler+0xc0/0xf0
>  el0t_32_sync+0x190/0x194
> Code: b000b520 91259c00 aa1303e1 94482015 (d4210000)
>=20


What was the setup for these two?  I'm running trinity, but I suspect
you are using stress-ng?  If so, what are the arguments?  My arm64 vm is
even lower memory than my x86_64 vm so I will probably have to adjust
accordingly.


Thanks,
Liam=
