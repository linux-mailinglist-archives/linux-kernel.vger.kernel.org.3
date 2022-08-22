Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62659BAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiHVH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHVH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:57:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CDD2AE22
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:57:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M6A5Ev019800;
        Mon, 22 Aug 2022 07:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=MNAZKtgG+7E4cujHIUN+jmZsW3g2wT8OXLSjG4+F7+c=;
 b=aycUcozXxU/GUWl6KV+LolWrd7LAG9zOnl5DIy5G6IqlnOB+lG7PrJO0BdpvSX1JVF5K
 sFq8uKsQo42fp5nh/kICeD5eBPA/1yK8BYfegwqG/FznmyWYHWqlJCH6g7GazrARXrED
 eBRIxH6S4lpFiJa5xMcdnUuvItd2chwXRtI72zg15yfLWGJgDFFyNx34XtfRw0AxoEw7
 2j0ePtwKWuAO+u8btrO255gvjXrbaI+jaDOnmH0jTurnphZas/dmTZ4MwYwCa+0k3up6
 bxxlfMbcS02tI8sRx8eUX3rU07lUS9XRX7Rl+Flbzhzd7qtsTUQG2OyreFcQKwvGrGTn 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j449pr8y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:57:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5LFxu038265;
        Mon, 22 Aug 2022 07:56:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkfqv5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 07:56:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyGeG7N2WBmkN01XS0u17gCv9MZac8WcUcSpOi7p7yl2THpD0+MBQ4VL8vgJtYMNkWOfvhHcOpQUDJT4V0VPi60JNqJhJDJlzvDDvOqUZRE6ykjNUX3bcuAX2c3pRUKMFmOY6MSlbOF5XHd2ZUWzePxNNeNQwv0WLdDSs88GU8N6IpC3BJOPIss1G/OtYfapt4TFtux7M5faD2w6+UQZHRPFRtNmUHWE408QP6Uy+yIAGn4n0uBFs1NSYbBt4fC8t/krfVoMWUBMygY5blDozTt6OMCOlhCLy+M4v9/r9Yv55QUfZZdFVXN//gyE1vAsAprEaFc9Iprzk0VgynE3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNAZKtgG+7E4cujHIUN+jmZsW3g2wT8OXLSjG4+F7+c=;
 b=JAvg3GTNKgMzdx89JKSW9gOoov7FBggQOLstTAnoCbIzeq7IMZBdnA6Dy4RrJTrlDIs6XmNq9OaNKKaNU+Sy8tY02UjxQ0pL/brj7nu9iiqpBy2czDS76WfIrHNbH7eiyf9OHeaPioPresuBx0YYC3wgwfdLzCcYpYImpCxmwd3YGvERKOehVrC85oRvKTkSvnwU4Lm4wHvCENZ4pmlpO44gT4N06uqSMstK+t9VVx4o2OnuIFw2gG3qrcfiiqiGHrBDWxOrZ+ir/SchafihXw/nPBu/7yihc11C2tqfmRSeXa7fI6I9ESD1ZwSZuBTH8ZKI2/elkeJK+xnuDWBy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNAZKtgG+7E4cujHIUN+jmZsW3g2wT8OXLSjG4+F7+c=;
 b=XMdnJvLSTi7USZGOJxaXS5OCvg4KP5F0GAviz/F9/e3Yd/7RsKh4s8mMXt26zZb7uyXyKOGHnGY0q40kbpyvgyLJt9Ezfe/EdYke6YLwJX57OeA1dTEPV0S5ywq/b2EpqFwnDBRwmZ8CHwOnkVlVzretUdnDIZ89vVGNqlVo9Tk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4296.namprd10.prod.outlook.com
 (2603:10b6:610:7a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 07:56:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 07:56:40 +0000
Date:   Mon, 22 Aug 2022 10:56:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: drivers/soundwire/qcom.c:1319 qcom_swrm_probe() warn: passing zero
 to 'PTR_ERR'
Message-ID: <202208202132.gxUTdHmB-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30bf1397-9828-4cfd-9bd3-08da8413d897
X-MS-TrafficTypeDiagnostic: CH2PR10MB4296:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pablTJ0hvNrFfczKzkp4UgprLUsdZIc0ZH1z6t9NNTRIlhFyO5HzdwWpiE/apdp6pNISg5k19CqCb35o1n5eMT13YwTQF+WHc5Sp8BJkBlzbifBER2SyZ3dJlqCgFsl4gK6kHx6iCbHbZc0nnW1nqAfRzHZqrLvXMRSlNVW8Q66D7kooBi+nFoMH121JIYVKbzKHqMHwvXiblxrNo9qvhW2yBejcOa5XcYPLtsQyMt99Zhqnh/L1LAqfaiv9udI7dWVp9/KQT3bQu3sBxIhHTOgcwDu+Z0GAR68cBdzAMm5DVeqxWxRH5yS8yHvvQvYBK6sX2yV/zqj97ypyvsZ6FBEc77cTt/WYLo20kvvo5nQi5qNIKzayQUTR5YfR5sDpmdJGJ550BX7OOCM6PAQ34B+PKf7vqd9apfKK0kz88/H4gyj/rZLMVty6/izfgM+VzlUYMZP6cDYKA/qvAGYgP+sbogeQ1XCBVZ3SRVE2XrftEtBRuiZzXLuoZ/HhvtQ6DyCwXzNDidLJdcaOIHtnNj6/lwpRejpSW2Fldkk9QAhNXJG3Pd6BAwoTLYH4OulCBXZ+iADbfvH2ugVI4Z6z/KKTupZ0gWCGO4cEixS/yS4DUUY1kaLLWNJXUaL8zhUsP2acV8LPftFUP7p+XLPgxoU6gG94E23b6PDEH8EYKacPVmE9be8extXN13ClF4ltaalfMqrIpatPFsUnTMljg4ApdNEA6etMnHk4l6exw+iCOIPF/embj4RzJORVx2kYgO0nxddt+Dd7z1FW7wkVH8XQw99MWYkggZeY9395U5SfOAAqhA6U4eoFpMywkuETy5IUobZWTaeqqMbERJWH2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(346002)(136003)(366004)(8676002)(4326008)(66556008)(66476007)(66946007)(86362001)(38350700002)(38100700002)(54906003)(6916009)(36756003)(26005)(6512007)(52116002)(1076003)(9686003)(6506007)(6666004)(41300700001)(478600001)(6486002)(966005)(8936002)(316002)(4001150100001)(83380400001)(2906002)(186003)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KBoRzlX/UEqEYk/Qnj/WCxEiQG+nu7H9XOtvg32R95cvB0+K19QzSJkwpxn?=
 =?us-ascii?Q?tP8w7uKWXC4A6JOR3s9TshwH3/WT6drsXjZbPqMXhw9JomGZ5G6M1qT9qV0e?=
 =?us-ascii?Q?tKIEDNVrhNUWlLC9EdnDyk4OfR5iqWZriIS5HtRPq1D4clKZabg5QkA7cixF?=
 =?us-ascii?Q?4lgBL/AgKgVf0GdYEWGHm0GCXSMPhpjjmDJDvwLBfbdKQdrQaKDtRZ5OBWCh?=
 =?us-ascii?Q?jhbJgEhJccspj1KxOqJn+JwoT8RXHU/lcZLEcAuQqfuyrJabaVvz3CrQhTT1?=
 =?us-ascii?Q?OEHULPbEOYa4+dxnfIkkni7a9o/g2YOEaLYZ2sj6f3x8Zmv0uVrDjJAo3cgl?=
 =?us-ascii?Q?H8w7iY3tbq5BKpWIOCh7pm4hBeCY67ffOv+FglXZvQzV3SioRjEbdGkNfUSY?=
 =?us-ascii?Q?NzDSh/P63QBqysTYkUPXHiAYqz9Uk3At15vS14/Cpc0Uy/DLNfX0xoQo4Zko?=
 =?us-ascii?Q?jgwJfNlY2sSSb1x26Kd1DFVPvqTuVCPfWwSqeh2THSTHN9lMRtyU0z8+j3yn?=
 =?us-ascii?Q?LJF5HHKS0XMRlz90D1mV09dQrxVYirhRfSApMgBvXJZEP13leN0etQRAbPEE?=
 =?us-ascii?Q?k09Xud+Awecb+Zek2UE3zBj6e0/IxAsir+zyxh2QHq01HSMy8B4OVp+r6GaN?=
 =?us-ascii?Q?7hupGQVuSesd64cCG54SsKlbtzpF2ccrOLXhIspkDwTift3BSrQeh1ZFp+H5?=
 =?us-ascii?Q?ZgQmrJ9FDGuipHfwmTDPqFdbHQftsxxgN7S9JVepg0QbTDa68222rR6uRYyy?=
 =?us-ascii?Q?UiirOKKtfitMfQadDccRKi0wlGd4gq+lE3wtR/j9NCv1OSNLBOsbl7oP7Wke?=
 =?us-ascii?Q?Y+ZdjFRXWUESOq5QP8ohnyOi6ibR4D3FMkfYj0qLKyLAaumyrrxONoWwd4YB?=
 =?us-ascii?Q?bQ/gcTkinEAlKeb01bLm+k5AC+K2HXfmO5y1aRtoz7oMMXi6Hjq4JAYWmQ7/?=
 =?us-ascii?Q?vpONGHtE8uLxj7qo4IjxNjxl3YLhuaCA+yrg1d8D5WxmpMLwrFElQlOGQGCL?=
 =?us-ascii?Q?SYkKmbBRO3fLH6UA8/pF8aBFCSpqmhGas6qBP7tv8PbkK8xUgsu0119hGhIP?=
 =?us-ascii?Q?Y8IsZtDaqy7mOOHI/aRI5IGKCWI7+JQcOXUlqjgxVhFgvRXAZCcau9DmHP9f?=
 =?us-ascii?Q?ali+KogWhEuWxi7T/b/MNv4J360NhuCuQYmiFgMQps6KBPnd3RG2nReMbXOl?=
 =?us-ascii?Q?t1CUmE8BNJvebMx4434mbfuMrePdu1gOmFBlVpu/kvE5dRXD7RCfYnxhYuUU?=
 =?us-ascii?Q?te/vL/QvQ9HWFJw0MUElXQLL6QQYQ0edwkyAPfQFMlaEw/CdEuDdYRtgasFK?=
 =?us-ascii?Q?UgOSOtujVYL8Ov9mMUX/VOJToGe3tlXEbx4zna/kZuWlqUuFRjXhfJwk6Dbf?=
 =?us-ascii?Q?HkYOGmtR685dzg17HPFmP0xZLE6Nxmxf2XZmDiJ202IZkOKGvPlgcikQSFK7?=
 =?us-ascii?Q?/EcqwldpZsXFH6AlLyujE6IqeNMOxLdBFSp5sUP6PUXkCOiZloUfKJj9NOcf?=
 =?us-ascii?Q?PS0+Zf3EztNK+/j+ngPocF9PHaNjo+s8yfUXihJuHL7pNVyvnCY4YLZg5zNr?=
 =?us-ascii?Q?DOG82ujb/d3Vq8pDKXr22A5nVFtYOF+wS2EUOCvU9LFcmmUGJDtpEbpwlXoZ?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bf1397-9828-4cfd-9bd3-08da8413d897
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 07:56:40.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aajkt0loyTsWElsy2j+hum6qo9TgX6CKKi5GyrjgLk+gGk5rR+ORvhEvovxjG1c7fYhctkcW7M5by0OX8trw1W/UN+6RYjY2aSaqfK8GuqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220033
X-Proofpoint-ORIG-GUID: dQF8XRmIPjcRR2Ehz2LB-o_4aFobP9JM
X-Proofpoint-GUID: dQF8XRmIPjcRR2Ehz2LB-o_4aFobP9JM
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
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: 1fd0d85affe4d64e54b81d04bf9577e57172a341 soundwire: qcom: Add flag for software clock gating check
config: riscv-randconfig-m031-20220819 (https://download.01.org/0day-ci/archive/20220820/202208202132.gxUTdHmB-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/soundwire/qcom.c:1319 qcom_swrm_probe() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting

vim +/PTR_ERR +1319 drivers/soundwire/qcom.c

02efb49aa805ce Srinivas Kandagatla     2020-01-13  1280  static int qcom_swrm_probe(struct platform_device *pdev)
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1281  {
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1282  	struct device *dev = &pdev->dev;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1283  	struct sdw_master_prop *prop;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1284  	struct sdw_bus_params *params;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1285  	struct qcom_swrm_ctrl *ctrl;
8cb3b4e74cd810 Srinivas Kandagatla     2020-09-17  1286  	const struct qcom_swrm_data *data;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1287  	int ret;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1288  	u32 val;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1289  
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1290  	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1291  	if (!ctrl)
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1292  		return -ENOMEM;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1293  
8cb3b4e74cd810 Srinivas Kandagatla     2020-09-17  1294  	data = of_device_get_match_data(dev);
8cb3b4e74cd810 Srinivas Kandagatla     2020-09-17  1295  	ctrl->rows_index = sdw_find_row_index(data->default_rows);
8cb3b4e74cd810 Srinivas Kandagatla     2020-09-17  1296  	ctrl->cols_index = sdw_find_col_index(data->default_cols);
47edc0104c61d6 Vinod Koul              2020-11-25  1297  #if IS_REACHABLE(CONFIG_SLIMBUS)
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1298  	if (dev->parent->bus == &slimbus_bus) {
5bd773242f75da Jonathan Marek          2020-09-05  1299  #else
5bd773242f75da Jonathan Marek          2020-09-05  1300  	if (false) {
5bd773242f75da Jonathan Marek          2020-09-05  1301  #endif
d1df23fe688b58 Jonathan Marek          2020-09-05  1302  		ctrl->reg_read = qcom_swrm_ahb_reg_read;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1303  		ctrl->reg_write = qcom_swrm_ahb_reg_write;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1304  		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1305  		if (!ctrl->regmap)
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1306  			return -EINVAL;
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1307  	} else {
82f5c70c26511b Jonathan Marek          2020-09-05  1308  		ctrl->reg_read = qcom_swrm_cpu_reg_read;
82f5c70c26511b Jonathan Marek          2020-09-05  1309  		ctrl->reg_write = qcom_swrm_cpu_reg_write;
82f5c70c26511b Jonathan Marek          2020-09-05  1310  		ctrl->mmio = devm_platform_ioremap_resource(pdev, 0);
82f5c70c26511b Jonathan Marek          2020-09-05  1311  		if (IS_ERR(ctrl->mmio))
82f5c70c26511b Jonathan Marek          2020-09-05  1312  			return PTR_ERR(ctrl->mmio);
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1313  	}
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1314  
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1315  	if (data->sw_clk_gate_required) {
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1316  		ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1317  		if (IS_ERR_OR_NULL(ctrl->audio_cgcr)) {
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1318  			dev_err(dev, "Failed to get cgcr reset ctrl required for SW gating\n");
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01 @1319  			ret = PTR_ERR(ctrl->audio_cgcr);

I believe that the IS_ERR_OR_NULL() check is wrong because
devm_reset_control_get_exclusive() does not return NULL.  That means
that this bug is harmless.

I wrote a blog about this:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

The TLDR; version is that when a function returns both error pointers
and NULLs then the NULL should be treated as a success path.  Do not
print an error message.  Continue probing the driver but add NULL checks
as necessary to support that the feature can be disabled.

The devm_reset_control_get_exclusive() function calls
__devm_reset_control_get() which *can* return NULL if we pass
"optional == true".  But devm_reset_control_get_exclusive() passes
"optional == false" so it is not optional and will either return a valid
pointer or an error pointer.

1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1320  			goto err_init;
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1321  		}
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1322  	}
1fd0d85affe4d6 Srinivasa Rao Mandadapu 2022-07-01  1323  
02efb49aa805ce Srinivas Kandagatla     2020-01-13  1324  	ctrl->irq = of_irq_get(dev->of_node, 0);
91b5cfc0209b63 Pierre-Louis Bossart    2020-04-30  1325  	if (ctrl->irq < 0) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

