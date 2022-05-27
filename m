Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F832535B37
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbiE0IN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiE0INX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:13:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2369DFD37A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:13:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R5sm87001688;
        Fri, 27 May 2022 08:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OQIBb0Df+qepmDSAXiHZ2bMjt9SUB/7h4fmvz8d3Y7s=;
 b=Frl8dApwfvGk18a7YxVhJWmwgwTDazuJ4PhRF2DSEq3Uqh7m4LF+zmUQ2DmYPY0LwvEP
 A8Zj8pkwk8YC5p3pm9Ioc/pihpK0K4aAzoiHvd2dw7pwJwpgGT2XYZB3/CMPR2wLwY5C
 cFkjB4qTK594XZqYcaSejN3dktvRmNNchYa2tpFPKNkE+7aIvte18RrrpbtTRev7Fnc+
 Vb5+QWeZl8AQXZgzSzp5iMiFZhNMXySMihabnRsrv4wjrL3tbDuSPnCHdeWW+HbcPZew
 FZHUEvjRXN5hNkVVjgGCv+BkGfvjYMdi6tlCgj8014kKqQGrPrAeW4sTjy2/ARk8dUL5 aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93t9xpb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:13:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24R86Jwe030165;
        Fri, 27 May 2022 08:13:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wy57c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=floioqLQ0AYwUbMSYGTI6e7J38OKQ4pEDqgL/jKLp2vm9AZOMVZTPMKi1X3g2IA9ie0HcgcQjNVgLmidQJ6OJQsdJ3aH7kv8pY7AtuhtRbOclhm9NXF3gkmOTe6dMyaxLypBUG/XydwbkKjfwYR2bsKB8z0BBeQD1HdryK4GHtsa1L+yXarorRhKd59B4xcEIIyaWwYNwQpITK1303MgD8L7d4ugiVAGzI3Ra+rev/LBU+3Oknlh0pRPX/pOB983smHk5gWFcUIQLnrvl0gEMia7G7as8nl6du6v3y+Ak0/bLrgW5NuyboT53YECshS4rf2faUNP6cQB37rxlJr2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQIBb0Df+qepmDSAXiHZ2bMjt9SUB/7h4fmvz8d3Y7s=;
 b=PftwUnIXcxPKCZ0JricAJBG7pmbQ7O55g0lWPt2d5XoEhaTXycm3UlNctLRa50Wc2tlsXzBpMbgt6Dh9J11hEMcHSaGoNjzGDJjW+Nr0yBlXCIJqEu4epby4Fp4W78IvY1OtxY1bKQ+3AedUTYme9I4puDpdcstb2A0VZvTfX5jvdmQ2HmY8fFXsVmYxLPG95StQuedhXkpg85XdXVpvuHm45qY8TVNzk/UlUKq7SmRs2btG/LAOxObxjXPZhOhERZYpbsbeVLi9U3bVDyzcr+ajupwhNK52Q9cBfel9lg0rSp5YDZi4cgyxK6bJcs1DQd5wPZUCAwYL8CCZfye6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQIBb0Df+qepmDSAXiHZ2bMjt9SUB/7h4fmvz8d3Y7s=;
 b=sjeGY/wM2VYpKpENFpVfOdMxcFlFx22bevg2rN4HmrXMri5/bfb/KLJWxVriVo6brevm0zAuzfGDniROCFYf4MBIZzVx0VaBSjiI88+30KQXQ+00a+vkSIBAd310nCn+idifoQfngJ+4+yQeEfeDQNh2AS5gm1EUnCg27jwLsIs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM4PR10MB6013.namprd10.prod.outlook.com
 (2603:10b6:8:ae::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 27 May
 2022 08:13:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 08:13:10 +0000
Date:   Fri, 27 May 2022 11:12:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Chen, Guchun" <Guchun.Chen@amd.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
Message-ID: <20220527081259.GN2168@kadam>
References: <202205271546.oV14N2r8-lkp@intel.com>
 <DM5PR12MB246988B514599DF631847549F1D89@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB246988B514599DF631847549F1D89@DM5PR12MB2469.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ac852b9-5710-4756-40ef-08da3fb8bd1d
X-MS-TrafficTypeDiagnostic: DM4PR10MB6013:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB60131A7EC41E6AC9DA8444328ED89@DM4PR10MB6013.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Fcs58ZEMcgxPYVicl8odjsEdCMl+mK+J7ZXj2KL/VyXyOJGf8oaJQfhcZFkVKi6aDRVsmFtMyx3i5R3aE0GuclvnOZG7C6BWw8VoVY6w1NcmytH696i6bIZv2tekWzaIF+xlISsUVdJ/R76fLfNNR2woc+nkx8HZHL15w1w819qlR4Ql9DG63jxsQPtk6nlFeD1laqRy0FIOIJP2a6y7D7TFQC48p4g+jeO1g2ZwQf72674+CF/zwe1YccLTRWIdERdthiMLuH1s8fUN4jq1AQe/5U2AKQwif76c+aQ0kSQcx75hkIedwxkC2GvPh5rlEGZlNGlmsxA/bvORb32TOFQ2vk5RaJ4v8OcmnWydSWOBCc7uePUwr9KZw0wEquQEVKkUttqKhBaKnOGQlGNclR+7p/khSR0beR3SFOzGMR6wtJssUCDj4ZbC3nHGYxtl68uQcgs/7xhaoDxSlIHhL5121X4qG9Gp+MZdtlClTU8EV7qSd6mOEJWrTkn1+NzPg2wrM8MA1Lt9B3q8FZxLJAMhD3KzobC7BIqLTDqDiTYSc85NY/AkeZ4UAPMEU+DWGBbNE94bhHG82MqDaQz8+HL9Bi1gpB+Bz5099Bs0CZzKnimHcRauCf6KhAwblSSRWLG4hGWT/zm1JVlvqh9At09kkycDT8FIX+hlMPrm1V2lbSGK52ULoFb7LClkcTNGlT7gmS9xErtyfBz377Oww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(316002)(38100700002)(38350700002)(54906003)(6916009)(33656002)(6506007)(5660300002)(6666004)(44832011)(52116002)(26005)(6512007)(66556008)(83380400001)(8936002)(9686003)(33716001)(1076003)(66476007)(4326008)(186003)(2906002)(4744005)(508600001)(8676002)(86362001)(966005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?meeI1XuVQNJDMtN+nefpEjB8b89+2DmKM2vuYYP+bwePaV2Hem9xW1NIoMEq?=
 =?us-ascii?Q?rDKKSTO7j7Y1dZldjeRKzBtx3VG8ALwGaZ9R/F0Wm0QJwfoTwLi/n9cEPUPb?=
 =?us-ascii?Q?gwPuCynB5PsxSMWossJ12ixfz0tGCh0DTdAeZ8P/Fp0BE2ir4VZ5LZO2Vv0l?=
 =?us-ascii?Q?GRwpJ7dArOLtd89baHP+MsyCCYtbJU5TCyJa7qfMJTrtKaEfaQ+zb6QRm66U?=
 =?us-ascii?Q?gKg4U2At4rrDP5bDQcwgCOw7MApPyaqHYhv+KIBf0HGIocdV4rfb6DxAUt1H?=
 =?us-ascii?Q?dAnGdmDuGl7BYQ4QhqSF6rJIQFA9YdWRvjC0+5aSGJCUSFmrP3DTOnDhlP3s?=
 =?us-ascii?Q?jbQ8dnTt2kbNq/ZHIahB2pjA8Q5tJUY3vc4Julvpa4xkDkZnRCb/cKMmg2Di?=
 =?us-ascii?Q?tsjYwDAkgrGd0kErS9+oo/S64tI6QDfsCG5ty2zraAZCjf8I/So+TMr2Mp/l?=
 =?us-ascii?Q?/kCIQa5klIB4Dk05njGQRIVCpMmcKhsHT9QQH/hSGxGjB74nBfrWDWkAN6zr?=
 =?us-ascii?Q?4AIuucnG+1g/UYva8RrK/y+61xvALL0vVDHIHmLn1wOozAwQxqiXlog+iMbp?=
 =?us-ascii?Q?KCpcTSTZ0cQfva3+BVFYigUXz2HLSQ4Bh3MDGRQ9rV4rEGsPIh1ynaJSmqJ6?=
 =?us-ascii?Q?00hicB9xOW1TfF/6Zpo2YEVyBRn9V48juFTFGz3blLDgdnDYIuuk1+TgfZ1t?=
 =?us-ascii?Q?tz2x7n/yrxyQSAAckwj0l4wK6s+tzFYhO8TMgKlneTE3eJyikmxuH6WZIMcJ?=
 =?us-ascii?Q?519jxJDEUhOlMafj4YtFG2bpQhuCwBqNqkvMGOvAyG8HuBSwLoPXRtsOR5Qr?=
 =?us-ascii?Q?7IgnmVEuPHMXT5JAXV8+tV0+hTIk4bksPgd2urqnHgFVnbUiaJcl5hD9UG0b?=
 =?us-ascii?Q?8hSv8pvLyQfnNOpBMBtAI8C2trI0jK8LuRq/JRi8eXF1cPzZt9zz78GvZyJl?=
 =?us-ascii?Q?iSni8drh7+autxBibTarGEbLuId7tWjbCXzJv3owZYZNLGSDalvtMWr3xj5z?=
 =?us-ascii?Q?EFI66sqHM8hIEIFjcpuhnbhsq/8RLzR6vzORMAN2entQKtehGMMNsAAxKNVw?=
 =?us-ascii?Q?73NPWFdQsXmXU55dvnxidUcmi0OKB2m5JSo5kIPysx6KYBffGBHUbTwXurvA?=
 =?us-ascii?Q?6xklmZCD5rGeZsMofcsdQ6h9NWvUWgBvEhsTTUL1hyO0vmpBk0RcO7hUwO5v?=
 =?us-ascii?Q?U2iTMDicILaYGgqnwmg0ZsNXSrAgsdjFm48kXuoZ2eYkC5x1Ixx4LQUkn/gd?=
 =?us-ascii?Q?KV7MZVgOV7O3RVF6AMYmwxjdR64WUgKEXq9kwVtqrzRw89dHzzZ4LEA406dm?=
 =?us-ascii?Q?05abB/Q9oGrBzRbcRY2FfMhjLknLeXMmYKNP1YYIQRd3OThEqfIv8wvXMYro?=
 =?us-ascii?Q?0opoMloCI2hs/KHu83QkXPt5F+y0NGyJSM2AntpIf6e6QGJ6Dh1Hv+BfLZfJ?=
 =?us-ascii?Q?nJF/tluIA2xauc6AsbbrU3CyuSMeJd7IHxg6zpq6vvtINwDnMsncrgB5hnQo?=
 =?us-ascii?Q?5A+VGRWL1kEmkCralGzBhWCbQfDNjKXVUeyhX+IvSg3LPJYNULEr6SihJcKF?=
 =?us-ascii?Q?hRt1+N54J8NgfaOR1oSG5ts1qOamWJtpDdIuJNNHc1qZh28fMjuUFoBfq6Lp?=
 =?us-ascii?Q?fh9qzjIkdqrJYKFYGSWPD1jt2neMhIj4uv6g+GkhSSfDHg7HaEtLBGFGYF8m?=
 =?us-ascii?Q?zsByBMF0r4O7tas+f921Zj0qUIMLsd1sJgZ7SoX4B86+nyAJBRRHp7miLeVg?=
 =?us-ascii?Q?hmqqyKP1lBTwuU8nxwupOqYXkCkiLXI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac852b9-5710-4756-40ef-08da3fb8bd1d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 08:13:10.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPCRb8f4QlILFT5F+rLrOnjlaIaJYIec8gMZniNJzSTGNaILV/ZxUipv+OoCiiMUswsKSOWBQjygMkMxZ32vd19eUoTeOHPtCTDKHODBfxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6013
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_02:2022-05-25,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=664 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270039
X-Proofpoint-ORIG-GUID: Df39yafjn1ONYdjDSAaJBYWaqLjsnV3K
X-Proofpoint-GUID: Df39yafjn1ONYdjDSAaJBYWaqLjsnV3K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 07:56:48AM +0000, Chen, Guchun wrote:
> A patch was available already to protect against such scenario.
> 
> https://patchwork.freedesktop.org/patch/486289/ , "drm/amdgpu/discovery: validate VCN and SDMA instances"
> 

What?  That's an unrelated patch and it has already been applied so I
took it into consideration when doing my analysis.

regards,
dan carpenter

