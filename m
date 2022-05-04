Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23531519996
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiEDIW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346220AbiEDIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:22:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE822BCC;
        Wed,  4 May 2022 01:18:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244686hJ026114;
        Wed, 4 May 2022 08:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=nWgvasDGMO+xsuiYbJatyXA8aSwx87XO4qsP6g9fvSw=;
 b=Fvm4b1Z6oJwFTmq1sMDG49QyvLx2Mm/Nmcfw2/b8p9KHg6wka91O9S1YMxc1bVKdk3Aj
 lCNoOYe+2B7+wAGDfXx2mlN5y16gO7qzS1jNRiI3cpyM+xmNvA5nem3gFkQw1JxmFCas
 tI5ZgwioCS60XvVR0NkU8zEIlDQtzJuiPl0c5bwozIJHiZoiN0Ay4qWYQRY42rn2SaFd
 CONG4uf7ISEnVVKPFzd/bJOJbWwIigdYh0qqmYJ09ZKIJJGnPBdnHWygl7wyrC+H0CjF
 uV4MNFcT5YAJJDWfE3nHz6UVpLbicDJ9TUqcb1EV1LAORWvI4JiOgcQVpr0AOKbC3c4R /A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc7mm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:18:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2448BLCw028277;
        Wed, 4 May 2022 08:18:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a5g3b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyTUZUXuSURypX+m7ehDSj+jI+DR+R3+90ufqq2gdMpBMbIS7INP9BnKwkQW+xpkBNX5Mxd5BxiV0Yjw2klpjEuka4kgoVQQSXDlDgisRQw3c2Hvlf/FgmdWUMGjB7PyDL3XmFoR6jNJ6+AVNpk5vBIA/EqKZHg2fwvgctiZD17f534hXbJRao/pVnOJGwqSdhOblXoKyKgd+7PZfQT/X0BsT8p++Y0t85VN/7oZ+r6jywEouWFATmWZP4xN6MsAE5bn8JCj4txOOPEhvpynQanZWYL+LL7SPXHq4UzbnTSUgqJyI5Xd9RrxZDyFYKxAPIiPv3A4SpODVOIG56pEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWgvasDGMO+xsuiYbJatyXA8aSwx87XO4qsP6g9fvSw=;
 b=LKOdwlfJV+3p9xpWg7UvVZ7ctvCxiRF3ApzYFfAPKFfzCxe+w3ee9PmjnHVWXeMTpjShKR/hRphau0D+zVUcwALlSzRO4ftHqBBNrsHAzkcDV8rIB/KVEznv1BqWozf9LQ4mGECqWD1D+mEeb188KDuxklICd3vHTxE4I/ZA+JRqyjMCma6OgpSSoiFq5ySgmY7e6GsGIBw2NcEFgGWivP7EziitbbXHxtJ4rrD+ECMuevUIpjfHV7k8DGrE40Za/sddWToZtokZ4lotY16boO4HZZs+V4sUWUiTR8Ywv0DfV2zJn9TvPC9IEuZ4P2gCzqQ150wKa+dsWH1N7viKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWgvasDGMO+xsuiYbJatyXA8aSwx87XO4qsP6g9fvSw=;
 b=KDBJKgsTrE0WZfzw1QrFdMebf+4WAdU9UNp0XFmZ7FE0HLnKaOSAlXhue3VFvlKtrDxGUnPLUXO0LShyLXomBubhSrlu/Aw9ZXyel2UwC30P1hmDXOQcK05dWADpcQ10yFbGDE6zNllEfSB1QUoX70hC8GzMzqxPemPijP+x/lY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1532.namprd10.prod.outlook.com
 (2603:10b6:3:10::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 08:18:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 08:18:18 +0000
Date:   Wed, 4 May 2022 11:18:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Daniel Lezcano <daniel.lezcano@linexp.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, khilman@baylibre.com,
        abailon@baylibre.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] thermal/of: Initialize trip points separately
Message-ID: <202205031504.J62WedEw-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426221523.3056696-16-daniel.lezcano@linexp.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa6a6220-b3b4-4514-655b-08da2da6a4c2
X-MS-TrafficTypeDiagnostic: DM5PR10MB1532:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1532F691189B0A6CC110D4558EC39@DM5PR10MB1532.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XumaED94lSk9YDpaMy+OeZApJHlsKJhaxF0VrrQst5hrojxa5lJjOAU2ey7KSvg2NcHcrmtJrpnYIbYt8tlvqReQTozhAlYjKRRSiYohZIPWA6ArjKpOyBGmK7CbmXEzT30GRKulLluX8p1Zp3YaEUe72KYASyDYIYCSs1jc0lM60tz5EFZJ8sNTDWgsyAbp718XMzaebx90wk8hp4f/1fEFArfv0gXRxVZx67MYBkvXt4USHBe8aBcH6jzUUsIl8RLkd+7qVx6TK/Maz9v5HiGPjn+B0fym2AqeMb4J7phTpxs1q0reR2bvND2MpjC61xqczCrZWagm7yMA8Je03t/WmSg2W5rpvBSTGcPXluAb0sijgP8L9t1lz1BgV9Atc0icYSr4aLqfZMPt9nAHdyyNZr8QJB6jCpCXlYy7+IZQkl9hZQIED5T+vt9yIXG9ZeUbxrUHWOt/Tc6/iZzO5APw+Ymydk/+7iL8xCNFKzVIDIP323ukc8Jrbfe63cvgTc8jdN5bE9wjNZKsOidwF+ddVpIc69jIxlLcPS+E2AzNDj9mYaTytvBXRpmxiXISvGh9UB8D+y21eq2iMXMPKTdtVj+p6BCLYNCzPxHj/fs4V/Z3Ue+kuXN7OvT3FF+8b7Wl7OfW45y3hKZUkURnOBGmAOSv3qwriW342RMvUsTiXwlUVvptS5V1DcDiJmqu2ylIVjJgY9PBE0cC32hQ/+T3e4dCOdW1wSnRxUDKQJvzmKjTAxL0DhmgO4P2Jb1TVgec/v+VZNqIqAfLmbdsqgC7ISTQx6AEb5VkCStIO/PJ+vAe3t1FlrzePIMWRLWb/HSN+Ltm43G5yNyhu5Kk9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(38350700002)(38100700002)(30864003)(44832011)(5660300002)(508600001)(966005)(7416002)(6666004)(6486002)(36756003)(83380400001)(86362001)(52116002)(186003)(6506007)(9686003)(6512007)(26005)(8936002)(66556008)(66946007)(8676002)(66476007)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rELhNxUQFT3GsRpXpWoOmhs80CWzYIZajAk2C1wtrBnyfjCuiDC1Ve+PCSmE?=
 =?us-ascii?Q?TFA1a8oRqk4HTzMShxaIcwI6QcUQ8nTMQ4yyhqAvPWXG+0dethdTJ6lR6M4/?=
 =?us-ascii?Q?m/VHaWuibVwvpIGSha8RrGR2bvwIq8MBCRgWYIX/rOV6YdKLLYYmf30ReuPT?=
 =?us-ascii?Q?Kr0grdz6/V+GJ16hdhuBS1wlJLTty9XOpUAvu9hfcNpTparPlyGWJES7TSmR?=
 =?us-ascii?Q?JJupdSJEAdNuXf9MJ/ovmB31a5sIWNDu2+Ttps4zJhHl5Jpl/INYW/C//16B?=
 =?us-ascii?Q?4jiyTsobCJ9h1hZDdjNYTV2SaBAjbl1Var5fn5bHb2JEtbeKiH5pL0qRQAw7?=
 =?us-ascii?Q?+uf9i27EDMu3NqQf4EV3x1vCCwSwc5g8XHJJu86N3I/F84RqZ5w/c7p162A2?=
 =?us-ascii?Q?HkUvihzXxgRlJlTEcBgA+cfS2Dl+OO9My42XOIt6EFVv/dz4f1ziyPoVZEh9?=
 =?us-ascii?Q?jiaNMuuThvq/ZWgvEfssrK5IAcuMx3ZkAxV+ouHriV6bwoLIWuDoilLxJcMg?=
 =?us-ascii?Q?LUxe4dzeEn7PRwei9c9G+nZargqVEOxpg0bBQYqDPp7YOFVI6Qhq/7n+wgdG?=
 =?us-ascii?Q?swEkRIyjhUfZCv+q6kdg3FBgdg7eN35CtCxmQAUWeI+1Ha3ljMfYjZJb9qLU?=
 =?us-ascii?Q?7+bsarO8rhY4ur0IeckmUQHOGPOVe7+U08lWZDZLWIUyhcFcYo1edCQ9gXL0?=
 =?us-ascii?Q?9HjrKWnqiwy8aY6pAN3rfrLnRtHJ4pAsoFSZGizRF+781OpQei+tplpgiia5?=
 =?us-ascii?Q?pDrqDgN3fCLQGZjrDe067AB1dfMvDtedbhfX6Isy1cRpsPYRgQCxcth2lN7r?=
 =?us-ascii?Q?9DKmZB+pttvMsBlwsSJpd/lxodblvOo6L7Y1Ib4TxZJUro5Cy4M/x5L4DSLY?=
 =?us-ascii?Q?lFqwV67e7G8VZN6BmWP8reIsxU0MXoijPODb8r9QD0SNzVQ0D7x2ZLG/ypIW?=
 =?us-ascii?Q?7E6ybo4ACH7FoIjQSfawbHYSnbihq8X+bWLDbODdRKZVl7zL2eYeBYw/T5Jg?=
 =?us-ascii?Q?drlSzUxm6vuvoLtJJRyX3PAPhoBGFWXl4e+em9t96aVkDnP72qzTiCLJEvGi?=
 =?us-ascii?Q?JYaMFzVAgzHLvbDrosZRroqUavFf0fEePETmcF8iNRaqw0xQu80WJ4g0TmSo?=
 =?us-ascii?Q?IkaVdvncWZ6MPUc35n2TN6KoF1a1cvDUfHO8E1je1q5kR5R8f/p8E+gfaScM?=
 =?us-ascii?Q?CwdN25sH0sAl5SPFcygm57R1l8ak6T1dIuw43RPyoBtQgVquyZCj+1BoYgyj?=
 =?us-ascii?Q?8Kwfr2NaoxspkoMukPl3mGCU94LGo+r2Hvmr9oHw/372HLU7UEHiQjtLakWn?=
 =?us-ascii?Q?2f6C8sopDNQaEwaZMVbfz7faFfQ/JDGCAfl/skj0H0LOrHBg9FvQ/LbSjUW3?=
 =?us-ascii?Q?k9EhS5ymjSF1adAO33DzJNE8tx25DMev9RxeOtmX06n5Tn1XB8Ip5+razdjt?=
 =?us-ascii?Q?1sSaUUPIq0RWoZhfFmZFJqtMFRCQstzCTsgujJj3u2aeTQOMVdhyLUz8U+7o?=
 =?us-ascii?Q?SeLGiRqSJkEOwgrPy3MqDMuYJYJIbictM96Qamgwd47Gp7u7OH5EiQe7Ngry?=
 =?us-ascii?Q?8VnDBLKyY3R62bWgBoXaj9U6bLaV7+V6S3YBJDQGzeBOjPaehKmc4DcA6ej1?=
 =?us-ascii?Q?r/scs+fTjxNq4EBhKxtbX/cncA96yFW7v+1fS85iH0RSigGuMqBz+bnI01+h?=
 =?us-ascii?Q?jBXlSFsVHL2F/vK06Ojf1HiyY6MfmeCNvzzxXOcynHiyfWf53aMTa264Bm71?=
 =?us-ascii?Q?w1La9xUWGZKlP+iMxt1FhJ8hSf6wCl8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6a6220-b3b4-4514-655b-08da2da6a4c2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 08:18:18.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1HJRHmG0Azv+rGBNIc4DO2vZvqZ5TVLSP6wgjMvTsW1tSFX4BsIYw4TYInRexlUp3XvBXzozfGy2T7H2LOpiv2pYOLJWEQLLoWGGreAqdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1532
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_02:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040055
X-Proofpoint-GUID: rVLFUJjVAT81p_X8a-xeGBL3Tp9fCFuM
X-Proofpoint-ORIG-GUID: rVLFUJjVAT81p_X8a-xeGBL3Tp9fCFuM
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-OF-rework/20220427-061937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220503/202205031504.J62WedEw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/thermal/thermal_of.c:996 thermal_of_build_thermal_zone() error: uninitialized symbol 'gchild'.

vim +/gchild +996 drivers/thermal/thermal_of.c

c0ff8aaae36955 drivers/thermal/of-thermal.c Julia Lawall       2016-04-19   902  static struct __thermal_zone
c0ff8aaae36955 drivers/thermal/of-thermal.c Julia Lawall       2016-04-19   903  __init *thermal_of_build_thermal_zone(struct device_node *np)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   904  {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   905  	struct device_node *child = NULL, *gchild;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   906  	struct __thermal_zone *tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   907  	int ret, i;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   908  	u32 prop, coef[2];
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   909  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   910  	if (!np) {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   911  		pr_err("no thermal zone np\n");
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   912  		return ERR_PTR(-EINVAL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   913  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   914  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   915  	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   916  	if (!tz)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   917  		return ERR_PTR(-ENOMEM);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   918  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   919  	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   920  	if (ret < 0) {
3079f340caa72a drivers/thermal/of-thermal.c Amit Kucheria      2019-01-21   921  		pr_err("%pOFn: missing polling-delay-passive property\n", np);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   922  		goto free_tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   923  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   924  	tz->passive_delay = prop;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   925  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   926  	ret = of_property_read_u32(np, "polling-delay", &prop);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   927  	if (ret < 0) {
3079f340caa72a drivers/thermal/of-thermal.c Amit Kucheria      2019-01-21   928  		pr_err("%pOFn: missing polling-delay property\n", np);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   929  		goto free_tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   930  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   931  	tz->polling_delay = prop;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   932  
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   933  	/*
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   934  	 * REVIST: for now, the thermal framework supports only
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   935  	 * one sensor per thermal zone. Thus, we are considering
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   936  	 * only the first two values as slope and offset.
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   937  	 */
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   938  	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   939  	if (ret == 0) {
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   940  		tz->slope = coef[0];
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   941  		tz->offset = coef[1];
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   942  	} else {
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   943  		tz->slope = 1;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   944  		tz->offset = 0;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   945  	}
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   946  
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   947  	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   948  	if (IS_ERR(tz->trips)) {
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   949  		ret = PTR_ERR(tz->trips);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   950  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   951  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   952  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   953  	/* cooling-maps */
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   954  	child = of_get_child_by_name(np, "cooling-maps");
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   955  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   956  	/* cooling-maps not provided */
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   957  	if (!child)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   958  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   959  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   960  	tz->num_tbps = of_get_child_count(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   961  	if (tz->num_tbps == 0)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   962  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   963  
6396bb221514d2 drivers/thermal/of-thermal.c Kees Cook          2018-06-12   964  	tz->tbps = kcalloc(tz->num_tbps, sizeof(*tz->tbps), GFP_KERNEL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   965  	if (!tz->tbps) {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   966  		ret = -ENOMEM;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   967  		goto free_trips;

"gchild" not initialized on this path.

4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   968  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   969  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   970  	i = 0;
ca9521b770c988 drivers/thermal/of-thermal.c Stephen Boyd       2014-06-18   971  	for_each_child_of_node(child, gchild) {
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   972  		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   973  		if (ret)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   974  			goto free_tbps;

Better to do the of_node_put(gchild); before the goto anyway.

ca9521b770c988 drivers/thermal/of-thermal.c Stephen Boyd       2014-06-18   975  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   976  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   977  finish:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   978  	of_node_put(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   979  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   980  	return tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   981  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   982  free_tbps:
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   983  	for (i = i - 1; i >= 0; i--) {
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   984  		struct __thermal_bind_params *tbp = tz->tbps + i;
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   985  		int j;
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   986  
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   987  		for (j = 0; j < tbp->count; j++)
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   988  			of_node_put(tbp->tcbp[j].cooling_device);
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   989  
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   990  		kfree(tbp->tcbp);
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   991  	}
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   992  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   993  	kfree(tz->tbps);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   994  free_trips:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   995  	kfree(tz->trips);
c2aad93c7edd5e drivers/thermal/of-thermal.c Vladimir Zapolskiy 2014-09-29  @996  	of_node_put(gchild);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   997  free_tz:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   998  	kfree(tz);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   999  	of_node_put(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1000  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1001  	return ERR_PTR(ret);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1002  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

