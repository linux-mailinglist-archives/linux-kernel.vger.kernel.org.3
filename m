Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3E1574B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiGNLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbiGNLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:00:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB33564EF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:00:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E9i0uZ024240;
        Thu, 14 Jul 2022 10:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Q4Rn/wEVV9ga2wTBpD/diT0nntXqjVA7VVNdA0xgLh8=;
 b=dJ6g+Mkh7L5nVB5puc3VSOZJTBgm6tw66iKVShqf1d+KoBTACl/slAjD77fGhHMdVll6
 q26zn6DUmRq87/oF9AjwDVdw55iNfYjQrTcoHTv7sXw6R+V6Swgv3+z6xR+Kb4E+DaDt
 4tgJ9s7De+TG/QQkzEui8wgMlz96QFal3Yjzh9hDA8SyLVsX8zO2EU++Wo3TEPAIBUh4
 nAmdW2XOeEAwMDGaWFqXZmHratvukXI/0SJUP4KbZEDBYqmsyVyDjxuVZQzDV6lnoElr
 gWnZ87SN+5THAYtNUp772OqiyHCHYEES3urCsL3/4zvFyyCr5fDLJaslII8A0Yoe/Kd1 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrmsc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 10:59:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EAterC013018;
        Thu, 14 Jul 2022 10:59:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045u3p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 10:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj940B4tJ7dByiTz5Otc0/2q/ZoSWy+l7TKJiBRdlYTioHKy6Ip59eltKco0G2KWuVQcBlS1OYx9IkOs/GjEYoBgLlmsQT8045BtXh9J7xQokTsMc7q3Mt6UzQtz3TUWtz5dlG8DrHeCv8h8LCg93/FMlSwaN5RE6r0fXbUjcqzh8FTEC5Ahp5ScwaNnFZBlF9mcveNZpHurjTcDog7r4fm9UMbf6rvrbYVBKyL+cKo85JKphv0DdtRPOC95z6cgeONeDR+XQ/M8ib+w9g4jWkB2OE4gInleDajYsjQExEoFI2D89VS+XhFWYyg9CU5i9I6eyxQKA5Xt95hSVskIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4Rn/wEVV9ga2wTBpD/diT0nntXqjVA7VVNdA0xgLh8=;
 b=J6+WFKwilsCxvaDY2ccnc9bgAM/HlOMo9R0W4rlkgcUgB6VsRD1P9+Q5MaofZB1Ckn739/7dkWQWpAuW+fUV9+cjI8BU8hu94q66VrBJhfOocWRfiSB7gWt5tlAC88qmZE9khqUlrH3qomvbvWHG8k06lMlREnnR2xqhsChBkZfVpoRokK0auphddytkWxLysCTKhEU+W7HD5A/xIVxeLZaemKBddxGHEZmxQTXUamIDp2P79a+hhTfgvagynyxmhmyeB44iyxYUTzJJCAF7BNg7S5advF3K0P4FYDhUj81dEsD0HCmtOUfaO6YiMs3U2EseHk2R2rKdCyNWr12auw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4Rn/wEVV9ga2wTBpD/diT0nntXqjVA7VVNdA0xgLh8=;
 b=y9Z4P65b5X5brIMppzwo4Be7TiZSJ2RYWFxLVPZZjURYceQ0kkta/6MOJdFOWBD6SbBZAFSpJdpRXyERnPST8laN168BLrUNp9siTIyi6Jp1f0lcVrUzzN/l7uhIn0yGiK3g/BG17PsRXWPHfex0XsqGBRcsYqCjAMAV1Z53RjI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1433.namprd10.prod.outlook.com
 (2603:10b6:3:e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 10:59:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 10:59:44 +0000
Date:   Thu, 14 Jul 2022 13:59:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Divya Koppera <Divya.Koppera@microchip.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn: passing
 zero to 'PTR_ERR'
Message-ID: <202207132330.qoXbH2DO-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c0ae02-0e3b-49cc-0184-08da6587f59a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1433:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orMTjTGVRMa6nDwrtfi3G9Yjxjt3I88bodKViEqsJq9+eMSJz0LdX9cr8eV4LE0GfIQVppFG21XkDtef5i91yVlMHOEK/7leM6KSrTRvAF5VG1+dZhGknnyx/cN9mUiW+KiJnw0HUndreyA5HeRYiZE5sbJzcczgOpY9Laj9+W1hwEN8qHRm+BDSjeJaYd57wCjaFe5jbe3ZibaY7n8q4eCDczzx+vhv/0tcYD4BbItn49cunwBBNLB7n/CIYgEpHGSQaVqT9HQi4DV0TBQD79/rZF6qsiZbjrXnsSP8S4pc0ss9e/Q+sc6ZKwpY0A7EV/M9UE3Z0Ln153V/TiOmkZai6RICX79V8AtIpyaxonesa/d1t28LleH3SEGAMZPjWhOMV6zytdh5pLIIiwB/SkaqIjSG/NoAyoSCtQLGOdYDWUF/O9/8LeHMH2kBv8QHUUfKou6IG9BrU6KH1vzDOc76jAXRcFwZuqPLgpZnX8xElzVPkJscJCNkWdf41T0z1ZxfEh85oV/2dAyx84rMvjGtIuUBi0L5zV1Y7Jek9COI7kGVxSgQSjUI28vrvD07AmzX+Psd4KyoaBEzebJsNS5gv+Uqt+Q9qBDYzHUFdKboYFYBnA3TzGET3bRMZ/AD044/hmdp5zBm2GoKIutF7gH//0UBDEbIi7oGIG8tOouSJ4l+8y6VVLijT0smYbWrOFPp41o1IClmCj6jWXBzp7poDVsLddSaGEFzksG0FGgE7UWzSCNWub5Wx4B1PJ4dP5nXFMODzXVX0RM5VK3CaNgNpsaj76QkJvK0hRqeaZ4Xgcu8hGWFvW8zVQZP+fTUjdRS9F/56tNdX77l4zNlpxuAJqKerH1LFO0BobpsiKhIh8dvuBVCqWkC8avzDOlj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(136003)(39860400002)(5660300002)(66946007)(66476007)(66556008)(44832011)(316002)(6666004)(6916009)(41300700001)(6486002)(966005)(478600001)(8936002)(4326008)(36756003)(8676002)(1076003)(9686003)(6512007)(6506007)(66574015)(2906002)(186003)(26005)(52116002)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FOU8E96pwbP1sxBkm4V+ZxrTEXqg5POtjvPL8vepzd1JsoYODZcw+hff6j7F?=
 =?us-ascii?Q?6O/V82Ej+BrlnOjxd4+VmrUqUtRAc6ekG2JecRZ6+ZxL6BefFgFRe4hE3ue6?=
 =?us-ascii?Q?wagqeXPLivYOGJbfMS14isp5DLitjyYfVAuh6JLPapOxKyFsSlEVTc3GYkHN?=
 =?us-ascii?Q?AmIUg3jEGLjCH7iB+MPjW/8NBlVIz3qnIWS3Eg+QZb12PESaW6+Oz321ITJp?=
 =?us-ascii?Q?EyTZjIG1vEqE+waMJdUzoK2djl3abO38dON5rgJROfWEOXdpKpP3x8sgrlbo?=
 =?us-ascii?Q?rkQGu6v/SQ6aFBf4JDLeaIZwuMLJRWgxRFcvM71FpSjFaanmbJyFyT4GUlV9?=
 =?us-ascii?Q?TXiMBhgqzORdldzM0fsYC/2rclHaiYb6vu9t2PNPIsHbmgwh3MIKZlBI4VY0?=
 =?us-ascii?Q?lIy/T0ABtKmykoTMbkIt7UdDqtpADnM123jc1/Zg1dUoJombMM+SBrMTMLuv?=
 =?us-ascii?Q?rTRL4W8uPTEjQmcFyWHkBys5a80hVGRKIBB7ZyVlMwUdzegwI5pkxtbpiBaf?=
 =?us-ascii?Q?uBj2wB/OQagcTIyfkPRdm5YsGiU7Blr/854YQvnJpW8PMEHt6jkg9p1ZZPgb?=
 =?us-ascii?Q?TiPKQSa1eJxMyaJz93n+koNfUxm6/mAr3B+4kL8rVLuUU3yeCRwb/sUGF40D?=
 =?us-ascii?Q?o0cMkEeaVI8R8sq3YPeEdlPiWDn+QWFcexiwX+T6q49IyzJj/fDCteLURgWk?=
 =?us-ascii?Q?RhNLjJNKBVM6phV06cMXWgto9Pov0CbD0zEusmpMR0shqU2fgEubx6Zidkwd?=
 =?us-ascii?Q?if3P/Emsht9nWdbz5KiBD0aclLE/5s9fpGh9JJeoD/TPb+lg6Rx+YA7k0Dv5?=
 =?us-ascii?Q?8rxkGPM38hbcdPYTnvOD/AvhZBJ7zcvkvcqUI1gPOvCpq0ltzm2MUAXZ8PrT?=
 =?us-ascii?Q?0CdUEKsG1G4qbSbgZg3nDlUY35Qsh2B570lxdT1SnYosEylfY66a5Bk4ec7W?=
 =?us-ascii?Q?C592vNfa13QSy7vVZSug8aeBCwxDgwTarEV/Vgj9N2S0wF34Hhjjg6X0BWzq?=
 =?us-ascii?Q?+wbOqG++k/mby4IUe2HML3YWaiFQX2M49+62R3t/DQ3Nn5RdqSvUY8sk99on?=
 =?us-ascii?Q?qRTv7qdQtS4YUaHSKq/xhZiAxZBcRLVGIV2ZHnZnAi1/HP0L7ewJVQUxMjJD?=
 =?us-ascii?Q?cga5LxRY5bXdxljcToE0HfuaND3Z/xddoR4FlKbORB0cV17ftZMyUaBwpBDd?=
 =?us-ascii?Q?OK6SjsOtLPcVmHDg3QW73Ix7Z6aq8tNQ+PzbDnzZDLSKniQFFGpWmWzZY3fW?=
 =?us-ascii?Q?tM/tnl6OD5yhP5AOt2xO83YEabkp1ICcvfXCV3wJqITsoyH5tv9Kx8IkAT9r?=
 =?us-ascii?Q?kxyK/k9PnbHws0rzqBMC6z62eP3DE7iXy4GL+zAgMGXGbSHc/h94XaxCWLhV?=
 =?us-ascii?Q?HZXpoKcPos8tyfzzB9mvo+rI7/4IJ4p7dcx+1wLAvvu/juWdO8OfGHesgOTL?=
 =?us-ascii?Q?7tEvgq4eMPdSSj1pyHSow0UAxxWqG67tqdsqTX5nbdvr7yr1MHGLBSfhHqX0?=
 =?us-ascii?Q?y4mEg0VBYLNalWGsah9+5fAT0jjQJUSMvX5qI8bB4O7GEzfWCV0oIw+xRLXz?=
 =?us-ascii?Q?SE/OvzEKwkG3mvMtHz2xrpFIogw+OrDokd2EveCrWo7m9H5yJEZEpkKfKIbi?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c0ae02-0e3b-49cc-0184-08da6587f59a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 10:59:44.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgYQnf3wfqi/JNfxhAHt/Russviw9kUqMgImp67z+aWpeOwjDLblT+7GrkEb84FncDjEBopA/FxyHmmE8jluo0L78EaNSZ5rvMiGpymBnhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_08:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140046
X-Proofpoint-GUID: VYzY2m8Vxex5AQL4IF-Z6QBfoiSHE8Us
X-Proofpoint-ORIG-GUID: VYzY2m8Vxex5AQL4IF-Z6QBfoiSHE8Us
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b047602d579b4fb028128a525f056bbdc890e7f0
commit: ece19502834d84ece2e056db28257ca2aa6e4d48 net: phy: micrel: 1588 support for LAN8814 phy
config: openrisc-randconfig-m031-20220712 (https://download.01.org/0day-ci/archive/20220713/202207132330.qoXbH2DO-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +2613 drivers/net/phy/micrel.c

ece19502834d84 Divya Koppera 2022-03-04  2589  static int lan8814_ptp_probe_once(struct phy_device *phydev)
ece19502834d84 Divya Koppera 2022-03-04  2590  {
ece19502834d84 Divya Koppera 2022-03-04  2591  	struct lan8814_shared_priv *shared = phydev->shared->priv;
ece19502834d84 Divya Koppera 2022-03-04  2592  
ece19502834d84 Divya Koppera 2022-03-04  2593  	/* Initialise shared lock for clock*/
ece19502834d84 Divya Koppera 2022-03-04  2594  	mutex_init(&shared->shared_lock);
ece19502834d84 Divya Koppera 2022-03-04  2595  
ece19502834d84 Divya Koppera 2022-03-04  2596  	shared->ptp_clock_info.owner = THIS_MODULE;
ece19502834d84 Divya Koppera 2022-03-04  2597  	snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
ece19502834d84 Divya Koppera 2022-03-04  2598  	shared->ptp_clock_info.max_adj = 31249999;
ece19502834d84 Divya Koppera 2022-03-04  2599  	shared->ptp_clock_info.n_alarm = 0;
ece19502834d84 Divya Koppera 2022-03-04  2600  	shared->ptp_clock_info.n_ext_ts = 0;
ece19502834d84 Divya Koppera 2022-03-04  2601  	shared->ptp_clock_info.n_pins = 0;
ece19502834d84 Divya Koppera 2022-03-04  2602  	shared->ptp_clock_info.pps = 0;
ece19502834d84 Divya Koppera 2022-03-04  2603  	shared->ptp_clock_info.pin_config = NULL;
ece19502834d84 Divya Koppera 2022-03-04  2604  	shared->ptp_clock_info.adjfine = lan8814_ptpci_adjfine;
ece19502834d84 Divya Koppera 2022-03-04  2605  	shared->ptp_clock_info.adjtime = lan8814_ptpci_adjtime;
ece19502834d84 Divya Koppera 2022-03-04  2606  	shared->ptp_clock_info.gettime64 = lan8814_ptpci_gettime64;
ece19502834d84 Divya Koppera 2022-03-04  2607  	shared->ptp_clock_info.settime64 = lan8814_ptpci_settime64;
ece19502834d84 Divya Koppera 2022-03-04  2608  	shared->ptp_clock_info.getcrosststamp = NULL;
ece19502834d84 Divya Koppera 2022-03-04  2609  
ece19502834d84 Divya Koppera 2022-03-04  2610  	shared->ptp_clock = ptp_clock_register(&shared->ptp_clock_info,
ece19502834d84 Divya Koppera 2022-03-04  2611  					       &phydev->mdio.dev);
ece19502834d84 Divya Koppera 2022-03-04  2612  	if (IS_ERR_OR_NULL(shared->ptp_clock)) {

This code isn't right.  It should be:

	if (IS_ERR((shared->ptp_clock))) {

If ptp_clock_register() returns NULL then it means that it was
deliberately disabled in the .config.  Ideally the driver could just
accept a NULL and continue to boot if that's what the user has asked
for.  However if that's not a valid option then just add a depend to the
Kconfig file.  The Kconfig stuff around CONFIG_PTP_1588_CLOCK is
slightly complicated and you might want to add a CONFIG_COMPILE_TEST
etc.

But what we don't want is what this code does which is allow the driver
to be compiled in such a way that it can never be used.

ece19502834d84 Divya Koppera 2022-03-04 @2613  		phydev_err(phydev, "ptp_clock_register failed %lu\n",
ece19502834d84 Divya Koppera 2022-03-04  2614  			   PTR_ERR(shared->ptp_clock));
ece19502834d84 Divya Koppera 2022-03-04  2615  		return -EINVAL;
ece19502834d84 Divya Koppera 2022-03-04  2616  	}
ece19502834d84 Divya Koppera 2022-03-04  2617  
ece19502834d84 Divya Koppera 2022-03-04  2618  	phydev_dbg(phydev, "successfully registered ptp clock\n");
ece19502834d84 Divya Koppera 2022-03-04  2619  
ece19502834d84 Divya Koppera 2022-03-04  2620  	shared->phydev = phydev;
ece19502834d84 Divya Koppera 2022-03-04  2621  
ece19502834d84 Divya Koppera 2022-03-04  2622  	/* The EP.4 is shared between all the PHYs in the package and also it
ece19502834d84 Divya Koppera 2022-03-04  2623  	 * can be accessed by any of the PHYs
ece19502834d84 Divya Koppera 2022-03-04  2624  	 */
ece19502834d84 Divya Koppera 2022-03-04  2625  	lanphy_write_page_reg(phydev, 4, LTC_HARD_RESET, LTC_HARD_RESET_);
ece19502834d84 Divya Koppera 2022-03-04  2626  	lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
ece19502834d84 Divya Koppera 2022-03-04  2627  			      PTP_OPERATING_MODE_STANDALONE_);
ece19502834d84 Divya Koppera 2022-03-04  2628  
ece19502834d84 Divya Koppera 2022-03-04  2629  	return 0;
ece19502834d84 Divya Koppera 2022-03-04  2630  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

