Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA82D55D78C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbiF0RT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiF0RTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:19:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED619A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:19:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RGH4up001813;
        Mon, 27 Jun 2022 17:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wo61g/Q5MUZ4LtKdZnDHV2MfT0MOg5u/j7x0OaK/5WU=;
 b=Ilc7PQLueM+vnr+DyhYDU7wd25mJh7WxcYxZlk696SQYFplwEUx30O9KLv2aHW3P9azz
 OxFB+Q0aKw8/0H6UAqftG535JiTo+ykVVirKSVOXtuugM1r3rtGucSDOF+xb6dzW4/BP
 UpcbiORSIbxrkQ6hg2bdNvR0pFSKI0sJmzoIrfCd2SHHzKSUUWur/0X3oDb6NXeYcr9K
 iTj7ziOp9b/h31oUEknVkGiqZXVomxa8L+TwWapuXTfX9/RDKh5BTe4AWkSdO1kSLqQg
 44cpPgWH8yqZi/5JtJ9aCaJpGr8oSjRRC2aQFwLyPD0iA/T1jWgSDI/BSV3DYVGEzmgo vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0bx1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 17:19:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RHC2KC033769;
        Mon, 27 Jun 2022 17:19:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt781ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 17:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5w1w+34b1mocCwxfZW+q7wbCAPB/zf0eH9wqGd3QFQrPAuiU1OXtr4Z9K49R/wzxl9jfympgmcY0TFZkdeNykuwORGmKcb8AQWcSV8q/TQUjwGw/ZRu8iwFSo0VThGocwg5YtjrKze4dxPIy2XmnezDP+Pz7z4VR5nB0+OQbQAujJm0VYvJuPx7dDINadkGp8d3HZGDc7Zh7Bi6TEOVRPgS7aApknYwZu7OIDc5L1kjl0f25YnthZgX5pZvoIuNLqpTds4OO7FWSUVh2jSx3GhN4OOkDS38Fx9FJ82TVKZQbhMzjYyrkFGHibGzR1gi+dNZH0KC5uY7gIQy6YLFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo61g/Q5MUZ4LtKdZnDHV2MfT0MOg5u/j7x0OaK/5WU=;
 b=hfPZxHAvTILxboR9nzCRj2tr6i2pX0Zn4wT7/UFxR5K8OmzoTQ3qM06Iw9FCDBHyBNBo+CW1XQxZVvGwxDalg7K0ljOdQrwPFlu967bvvWRIWwhiUeSXxROeOhA7uq/WZ552GJY35IAQC1FKf7yyp2kaiCc33lEzY2Q08x9dvh/lqJpGF1jlm89tvh48iisSNb+ElrWiSKvFHH8nzawRlJDcX4t4bsFqLW7d2TtcyyjtEgGUsgiFq+5BXmwPPIYoTZbY7d9g9tAQ7OTOIez4zlSMY0Gyq7LObeyj396GOErDPxG8tP8srNBzv+9nU+RRzlf6JirUSJ4wvzbM8hvRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo61g/Q5MUZ4LtKdZnDHV2MfT0MOg5u/j7x0OaK/5WU=;
 b=slxu4GrtNG0GvNjeic/IB0j4aB+gLNopycCGFn7A/OLPK4ByWte5mXcJ4Ef6mBgQwHyZlhMM7qp8VpecT5HmaItQyFqhOQXHN2h4MYBKE29qdTuAIR+rde/oM5Y1JFasd57UPo90flDf7wcrR2ABFGXyY0hWPkKqYeaMj9bBI7w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1642.namprd10.prod.outlook.com (2603:10b6:4:b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Mon, 27 Jun 2022 17:19:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 17:19:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QCAB70xgIABL6QAgAAImQCAAAv4AIAAj14AgAJ+wgCAAAEDAIAAAiIA
Date:   Mon, 27 Jun 2022 17:19:18 +0000
Message-ID: <25C37F40-7D8E-41C6-961F-0774C8138CCB@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
 <20220624190819.59df11d3@rorschach.local.home>
 <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
 <20220625134552.08c1a23a@rorschach.local.home>
 <0bf1d366-348c-0f91-8f0a-fc9cc6228783@kernel.org>
 <12417afa-331b-e0f6-a3b0-19623e38590b@eaglescrag.net>
 <308F6A3B-1FB9-42CD-8239-12B0FD0F5FDB@oracle.com>
 <20220627131140.56761db9@gandalf.local.home>
In-Reply-To: <20220627131140.56761db9@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6390dd34-b271-4cd2-adf1-08da58612b64
x-ms-traffictypediagnostic: DM5PR10MB1642:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBrWuu4DqfdA7eGKhwD7zRdpG6AVpCpnDK5Yf/qtcD6RKUmcAiIWGiUR7YjU8hYlSU2H8tH1X9TziN7K8bLBdMaAzUH0kmgDyJ1gg1oRdkbCYsP4cZ22Q1EDj5/WAc342Qi7GpWWmKnrltRApxcgSJFp9tWIoBS7YZmjIIOA1wSdkNWmiqI9T0Tb/+Vx3fyaD7QBsRr/6mTo8aIg+ExEPKDwIaFfddiI6GgYm/I4vNTcdXAWanZ1yvQ33a5zYD0dLx3UjRkgtz6Nq7Sr0QKelHt9tv80yyGK8hWjLea1DkPlayFAuu4K0LJDFVqaCUVhgvs9sR3bs9wppTWj8eJ4CV4SVtCRsC5EawbCp8+8EhBHo9RgAccdr10puFDa/aF0KS4sxq1ZOaXKi/mfThlQULHZMc5tRJfgasZhZE5IbBMBPDIeju5XCQOZLxSxUw78e60K1NfyarPJx25sacxQBqs6qSm+/FSQvdMbZVXeckysxCP3IgzYCCobzia58iiA3LWS8ZKPcvOGVcLoHjq6guMqGF2Dvo00Qbymu2LNODxISzfA8LOvqksB8qwQ4eEEumGx/YMzQMVIN40FZQzPamJycjEd/lVCMxMtr6sn9TKlNl9+J8QWgsXKnXADP+YpJD5tSSYOtcgLOPu4L15d7LNu9/T5SbcMWbeDxqh3U2UxS7KMX4z++eDXAz7Z65vHs/dneaF89smb+U7359qA5vVGfX5msJaYlFzks22rWv9uL5zD8prWlpQodyfVDur2feVdr86evrS0gKiYLsClaOrzDCcjnNqnLEE3QSp4bBmk8X1Nh2wu89NVTKQGn9Kti5SbzqA8Fm8IT7dr/f6S6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(376002)(366004)(136003)(66476007)(66446008)(6486002)(66556008)(4326008)(38070700005)(8676002)(64756008)(71200400001)(478600001)(26005)(86362001)(66946007)(53546011)(6512007)(76116006)(6506007)(91956017)(41300700001)(2906002)(6916009)(36756003)(38100700002)(8936002)(122000001)(186003)(2616005)(54906003)(33656002)(83380400001)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S3AiKBt7mDqE4W6UHjZHiDSOvS4mXOnUpt/63X1qzgAW5+c0Wc1oU428BQUl?=
 =?us-ascii?Q?HxTjUCLVqI++ZzL6vkhqzcyzEB7MuhgApiBL9LwtFUCUyi0ztuxMeI7poa7S?=
 =?us-ascii?Q?Fmq/Mup+nYkSwOxvOJ/+7zg0le5WHkv9bdDPgKZypDeon2pM8kxoGdfhvL1l?=
 =?us-ascii?Q?wIpls4aQQd8sz0H0lfHRsIQ2tfieFic4ZLbyl/Pv3HZ54HLc746sXDy/hfGT?=
 =?us-ascii?Q?xg93Y6g2Hoyu1ef4JQ7vibuKZ+mNES0oWiRN80kw5eoNQeb0WfBpx2MoFxFa?=
 =?us-ascii?Q?Au/VEp8Ay18UInjSFnGVdRw06MSFRWfXai0GcGxBzBa2j0gS7Y0D3+yFj74b?=
 =?us-ascii?Q?s6+uP6MySs/7fihH0e8DRxBIonAETVOnulP7bBqaZ1+rxr1CRKo4FPkR8SqJ?=
 =?us-ascii?Q?qz/9FhS0kk+QdrCB6g8Mz+rlQlNfkyRtk8mJXvk4Tj4tgW644igVZ8V3BNe+?=
 =?us-ascii?Q?c0RXb04BUk/V9hslKmODS+mN6loESdmK3gA3p0Rr6pZvD/OBrsAn5uSRCWo8?=
 =?us-ascii?Q?8Up7k+60a+dzyx8WzjCKh1fO/H8yCVTRWjTg+v0a1T8k2TuXeuekvxrxVVr3?=
 =?us-ascii?Q?m46rN+xY5Lc1bouXQX6dbs+WN8eGCxhtEPEzoOkIen3P5XyNVerLWqd6kQzc?=
 =?us-ascii?Q?nUy5Hs5I/+EuBtEzBTmjKy2U26bckTj5h++mcyDPx5zkQu/pdlrZedxYuL8b?=
 =?us-ascii?Q?60kDXWyhZBnW4usbw+w7r+N8MYrbFwsy9GyGMEbiVOcLcs9mVN7vUI9RxO/2?=
 =?us-ascii?Q?KOkKmy1/F5n/EPQ64IZkiS2HUAKjv/kWFlPVybzOm7YLgUfEyQ/LGyV6Hf1l?=
 =?us-ascii?Q?abRC5xBRDtDQ91b1a+PH7WBITkCyET2/qFF0SIiuhYgaSMXUU8qjfA7HqY98?=
 =?us-ascii?Q?gx/SCN43lEyzqUp8dudZeqi4rrmeGgs3dBIFCuJh7lUMob6JnUM3THJBIdug?=
 =?us-ascii?Q?Nx4sEomK+NQLcdLt8G1pWz5N6+/mjDLgOjmfW6u3/6HCFKxYpvD9W1xjG7Zt?=
 =?us-ascii?Q?wykUgVd33kclWDLjl9oDlLz/k78wDAVZzJ01D9TCt2uNoT+XL+iYnFAptpE+?=
 =?us-ascii?Q?u2jAJsGuxeNyK8hCYN8/CWUgDu76mylPLVsiZZ/gxK0ZSVlJVMfHqBscuyVg?=
 =?us-ascii?Q?MxCRjFy98cnlNoCveCzMQuUZDJOcYZhODQ/bOlpYSVDmxQHbtCFm1zT3MLjB?=
 =?us-ascii?Q?WxItbaHNWewI3NngcoSxpdJ9PiF1B1rDkaE6hZWbGCQL3Z9qkkxdsMgdqspz?=
 =?us-ascii?Q?STVgZgZgzuFd98yTLUePvMgV6qck7uTsSG32PCQwFplkeOvD0slagio9skvH?=
 =?us-ascii?Q?3Yl8RGI158lVIbfjBLq2KqIvNTMNc9lJNOwSZuih8e/198yCOCIu+QQbvY1A?=
 =?us-ascii?Q?h2KxBF2UAH7IB+B4dWrcwJrmCOoV4w/A526g2weZECbWnnRvQ6e2ncx3DVvW?=
 =?us-ascii?Q?NkK8MkileWRNW4vz0cxHQONYB/u/SRNYxPnHD2ZLWcMFn5RdejX4WD3vuZhj?=
 =?us-ascii?Q?1iCUJY2dFhvPvPgwF+OhLUvq4sKxyMG5/T9WbuLXnLCdBAQYj6hZulLiXLS4?=
 =?us-ascii?Q?S9grJSlzuwpBwqPPewGkigT5wch+bXVlJ6KMmdZMDkHaYlgYuvGpBh55X4h5?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AD463AD3258D542897C62371A5085E4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6390dd34-b271-4cd2-adf1-08da58612b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 17:19:18.9124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXiloq/RgoZnWH0MAqrS0WxM+ufAI5/ge64peub7VVbHDuZLnBm98MakUZTmNAjlVE5TT018PL5N12HrN8vWFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=872 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270071
X-Proofpoint-GUID: gbmlS6BnzKgELyM94V8vTiI4VrHkPFnk
X-Proofpoint-ORIG-GUID: gbmlS6BnzKgELyM94V8vTiI4VrHkPFnk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 27, 2022, at 1:11 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Mon, 27 Jun 2022 17:08:03 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>> Updated from your copr repo. The problem persists.
>=20
> The symbol lookup problem still exists. What about the get_sockaddr() not
> processing?

"trace-cmd report" no longer produces the get_sockaddr warning messages,
but tracepoints that use __get_sockaddr() still FAIL TO PARSE on my
system:

            nfsd-1167  [005]   117.853235: nfsd_cb_probe:        [FAILED TO=
 PARSE] state=3D0x1 cl_boot=3D1656349219 cl_id=3D3054917767 addr=3DARRAY[02=
, 00, 00, 00, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
   kworker/u24:2-985   [003]   117.853368: nfsd_cb_setup:        [FAILED TO=
 PARSE] cl_boot=3D1656349219 cl_id=3D3054917767 authflavor=3D0x1 addr=3DARR=
AY[02, 00, 00, 00, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00] netid=3D=
rdma
   kworker/u24:2-985   [003]   117.853370: nfsd_cb_state:        [FAILED TO=
 PARSE] state=3D0x0 cl_boot=3D1656349219 cl_id=3D3054917767 addr=3DARRAY[02=
, 00, 00, 00, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]


> Would you be able to send me a trace.dat file that has this issue?

Sending under separate cover.


--
Chuck Lever


