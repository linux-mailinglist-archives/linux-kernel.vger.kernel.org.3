Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FEF538BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiEaHXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiEaHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:23:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB385A2D4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:23:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UNxDKX026549;
        Tue, 31 May 2022 07:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1NZIoTEm0cTyMRxZlJnxyjKF1iL+tPc6lGBERkNMd6o=;
 b=JWVslNEP7udn8Vho20DvoSCyxsjPNsckFp2UmmlDMqnA1X1fYbf7AuIGgk9ceuTK8DVX
 zMCa3rGq7XdMWHNR/Ss9h8bjoz9WYlbAtXjshLQ9w4xYlzbqwn+m0xLNO0BNKNBbzmx0
 kHAWIpNXsvCBiaomn+z/Ebl6XTt4PTcMg3xRtdv3wcxPEfdDowPKypQxsPBJjoGGEpca
 7QpoD22pG+resmMAmUQcacbcxeKSGXk/myYsvmAjd6ZOWQzBgA/hzxXiOjwr/2ee0Rtg
 fyCmIIACNcXDwmeY2EF/bI+LDiveG3QMmEv1sHEhB++FoFvdhpdm4HmxJqexyhR64ixs eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm3y69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 07:22:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24V79ro5008714;
        Tue, 31 May 2022 07:22:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hradrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 07:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTt7Bt/+cE4JtU4L6V7iXEC5/X23oM4g8y92JPArSp3mzXlXfisFaE7vsoQ73o8iYG1++mJniE2OdBs864iQhayg3ojV/q0Dj2chl9alsPkl1YN3iZtJQ7NEX9mEUNtC4GI5yYb64h3GhxnvL2oyNNau/AXHDZYuaKmWI1uFDUnt1o6VfNBv4DsAOvoorFsv8i/I5e3GL20oqqmV/KNmnYNBjIhlWSAwQMgbcvqxgLHxE5KhG1GfxUxNZQoY1bkPNL2EmBjphb47KxkQUWS9uUyu0xCtUW1nTO82qgGCmHGjX+pBx+vmsfo+U62wo016kjxzQfufYAyH5mqwfoh+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NZIoTEm0cTyMRxZlJnxyjKF1iL+tPc6lGBERkNMd6o=;
 b=HWBtWRR9XD1dUXMCwBH2eR4WM/C7sf+HkSMmu9Qjn0dRQLNT7Sjo3kaHNqUUibN+dKNSsEwLWKk82UdVSBDvvW6F1uNsFaiPnV+hdndLsfmh/riuCoz3EaGl/cocExkstZrwpjVl/Vh43ow2dZC8ZPMSpkouOctzaZjf2Ukbd82o+N3d4IHmXkJjir/fzm5iv3/Fwvmmpf1eDalHNas2faNnqAsH17PdgoXXtfQlDfJVV/DiHcweH8ITQ0kCy1cxuthcBpHebPawJ9XxnrR+op2b0f7rhyuKYx9mmWi86PyDP0mmJI2Hu+j8qkEdvWdp+OqAkgXzMYNmuGh5rDUngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NZIoTEm0cTyMRxZlJnxyjKF1iL+tPc6lGBERkNMd6o=;
 b=fVEci22LT5VG//KLsvVZg7L53kpkwe/3Cxh5o+LfETXldZxz3RnW2X+kapylpw0U1x/I9N5XqTXN/J3OlA88K9d5n2a7jk4j3w3VP09BccOEvJCP/czRmYi5IHC/sQ6x5cNg81fU4iwFV0RlcqA7/Q/aPYdGFC4iB2zekgkAgGw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2293.namprd10.prod.outlook.com
 (2603:10b6:910:44::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 07:22:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 07:22:41 +0000
Date:   Tue, 31 May 2022 10:22:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vinod Koul <vkoul@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/i2c/busses/i2c-qcom-geni.c:626 geni_i2c_gpi_xfer() error:
 uninitialized symbol 'rx_addr'.
Message-ID: <202205310736.Oh37uaNh-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffce31c8-c227-4cd4-cd6e-08da42d65946
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2293:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB22930BB26520B72EBEE6F6588EDC9@CY4PR1001MB2293.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/TUWhrHtD/ysYOcxH78ZowWxgMB5MsTcddAiqHAIOZeg6vEOoo7xFwGKnHPpJ3AlBHqZTUm0nPzyD7Q6vYwW7qd88e65fIWHbwcjF3UuHPvC8r3axOva5rb5++J5Qr7feBSwu+IzlpzBajqwcsr6P/8LxzLIAa28wMi0b6stxgohMvKd6XV9pe9X6f8ESKM89Tg6EKGCWE/4kMsvDB4HRgWadU3CDcNFGrB2ytdJ0CWy9ceetTalprq+fverYu1XW7tCgvgCZtDcrfgifcMbF3c1ZNohBgFW7w3+bGYEPkj5fha4VdOZ0l/p77ClSxME0zsyXYnx7vQh08o12Etg3ST09z+zQP5y3qm94vWhpU1UTy8NWrJIVU9GTN4dmcv8GltPiQAXGGYmrlPhH7j2HoCC57PaM00HPDwKuYJnDUjeZTPzTo6jzzPE3dg6jGuCjzeh6A2DM++fRjCdDjypRqlExMje7KusUiHjADnpiqra2p7vZsiLfoNF5Kr3gO1P1qtvzoMrwO0dLotQj6sVhSwNgNJx+8RzAp1K1G9d2oO/RgouiIx4Yk08Svtt742I5I53unBRALLN/wd1vj3HWRElaBReWFJAwiE0GODZMGFnUvxSB1NzWZ3jDoIqohUtcDNv/dwEvHBE6u97/hUMrOXWc+E5JmODgIqrbwdZ6f7Ui+NsBXabtkFfPUfVjo3ySqswrlfw7l/5mWpTELUhFyZQKSlyQETUyqAKzayoh5Bf9Hcs96AgnTD5Ns0hFOtUnacAq3++X3LIAB0sBnPbQBpoMW2PEdvSUWEXe+09JgbRdz6JekJJtXpFcNBFv4hGoihbBbFnO1cQE4ZeGH258Rjacv3OTRSPrFTZs5kayk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(1076003)(9686003)(26005)(6512007)(508600001)(6486002)(5660300002)(966005)(6666004)(38350700002)(2906002)(52116002)(186003)(6506007)(83380400001)(44832011)(4326008)(66476007)(8676002)(66556008)(66946007)(38100700002)(36756003)(54906003)(6916009)(316002)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+5xa/PPADSGPuRCHLMGa3o6Vf7eRnV8LcfQ5zbSKDWza4Z0WQeOfRFAuiZ22?=
 =?us-ascii?Q?NXfG1JNIqqssWwKbGPgwQU0/h+bWl6HL1EH/ZclXOLtAc3FiMgM845Earpr9?=
 =?us-ascii?Q?7YshDWgFC/BXThZumubKrWvp5MoEQFcRRAoHTTlhjREpIDms+7M7NNN9dgFD?=
 =?us-ascii?Q?JV56d6QdWTZmP1Pred/XVE4OHdfJlHlihvADcs+s99NYNwFyMtjfXXIyun4m?=
 =?us-ascii?Q?c/k+mNafliA1AymIvUIXaxMihCo86fksAfjOZKxxSDgop+XVCEh/koLsTiw/?=
 =?us-ascii?Q?TkEu0vceLW2Sv4zKt0xDLUSrKsf+3fOgEQO8FUY03+umEx24c10vXFdI7+9S?=
 =?us-ascii?Q?0KUmt+aqFiq1Jhn17gZALljMUkMTVOAcfh1OKWx76b6HDCZ2zjqY6lz+BvPK?=
 =?us-ascii?Q?p2ybNOD6DzSrLdy8+8x/6EqH6mh7TnEg9Ok3sWufH54HYBAUrZL9MYH3iexw?=
 =?us-ascii?Q?0PfswhE1Ny0dUgPvWLZv8LGRStvNx1nhPpklh/2pF8bKTRvntMXWWLvBbSKK?=
 =?us-ascii?Q?ljx+nmJgZtR08m9Uyytx2vBeRx03mhmlpH5BkleU7JRKP7DxZySAO/vdDFgo?=
 =?us-ascii?Q?iNLX008EnrbE4bLsoQyxETqq8Y4ocPpTmVwHId5ZF+HBN0LfbjpmLIML2bfO?=
 =?us-ascii?Q?cma0ZCmDV8UnX1Yueu98JtHKr8KFA5Ie0zzepAVFKVfAH/SfC0bYVKGlV3C5?=
 =?us-ascii?Q?g6AfTnutoIQAwsUOHTGl8eEtMSE70LqkIxeCxpyLFbqSMVuqvJCk7ZbYZH8e?=
 =?us-ascii?Q?dVA6nl12FUt3pP59cne7qYlc5nwUX3gjM2rXJjjqTKhP1F9+yrQFwZowIz9J?=
 =?us-ascii?Q?Ia+cb7UjV44R6Frk/XF1OWRmlXVfcOdN/i9Irr4gGLDOWSKJHLhQnGNy3dPI?=
 =?us-ascii?Q?ovX6kHlEPgAILYfp2Lq8gketePsB9RBi2MV9hLWeBJMAxpjKJxG+JKkQI3by?=
 =?us-ascii?Q?CiOD6cdjAHas6M0+I4huQZe+1X5jjjUxgwww4T8DH0GK4WWrLxawMhmuWcch?=
 =?us-ascii?Q?deaXTsV4bWinZXMVHTrzjyqKQfH9htLNBFjTS8UXXubqZ7hqndasyy4PgImp?=
 =?us-ascii?Q?Uize/gfQnwVt18a5QkywWY08ASsIQDNSntumZxkg8bazL9DJ2rSpmx+samMC?=
 =?us-ascii?Q?w3P9lh/mQXvikE3OSpbzt7EPqpxORXlu/TuftIPZEqIZFRqa+OuBW+roFCVq?=
 =?us-ascii?Q?udo5gzBiKDS3mErqgXtJlgfTCx5Ekqn8zP5KnxrId7zIJvKHpg8hpv773Lm/?=
 =?us-ascii?Q?7l7FE1YVKsnrmClOsZoZgnpt04ju9DtvngywTWvi2xuS+oCZQP5M0JLypezj?=
 =?us-ascii?Q?aVmYFG5zJgmpRR0TnA2sNggJp3T37aVfSJJ6ED3ykNI/ch9a5Ee2ZylHGD5P?=
 =?us-ascii?Q?a/yk3eo31Zd11bT9cNKWSx+O2qsdOEEqCyW6+zsBXXad2mEEKOUSdX6Bxzcb?=
 =?us-ascii?Q?addAdcqxP3wXYNUZ5wmUAQAJzWWQXOg3uPMYTMVpoKFBn8+80fbTbOW9jTQC?=
 =?us-ascii?Q?lxG6dYwGkxEEiEgtKb1G/Yp/hhDvfo4qXKAjiR1voXVDZ3cS4VQrLEhk4Jbl?=
 =?us-ascii?Q?N/7uqEYKgrWYUHmGJgRzM5r5CbD4N3IGdS0/jU8krI++BKdJgD+Rhq6DWfdE?=
 =?us-ascii?Q?0l6bSv5WxQe8hYfP4obaorH7wV5LGpO3c5sRWxYR0eBOVYCcO3+fA+g4PRTW?=
 =?us-ascii?Q?no9o0DoVyhUHrbKyQvosHX3MwFUgRD35sAhRYfDGoa4d8RvXtbTLQsoxn34W?=
 =?us-ascii?Q?Lj+B3XVkxJTCobwMPrBuck0iYL2crik=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffce31c8-c227-4cd4-cd6e-08da42d65946
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 07:22:41.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TmuLEBw5rZHxz/6fbD/fi1s3peEL+wFWVTjVHyZzGStFDWfK0KenU8ugLC5DfK1vzZkvBmNGZC8vNOT7ANv9INc0OO9nx2o1vVQGkbhggg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2293
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_02:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310037
X-Proofpoint-GUID: XxGfOkJfM-NkxcJvJQRz14gMj13kRgZU
X-Proofpoint-ORIG-GUID: XxGfOkJfM-NkxcJvJQRz14gMj13kRgZU
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
head:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
commit: d8703554f4dea9775417525b22b3d65ed1c6b16e i2c: qcom-geni: Add support for GPI DMA
config: arm64-randconfig-m031-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310736.Oh37uaNh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/i2c/busses/i2c-qcom-geni.c:626 geni_i2c_gpi_xfer() error: uninitialized symbol 'rx_addr'.
drivers/i2c/busses/i2c-qcom-geni.c:635 geni_i2c_gpi_xfer() error: uninitialized symbol 'tx_addr'.

vim +/rx_addr +626 drivers/i2c/busses/i2c-qcom-geni.c

d8703554f4dea9 Vinod Koul 2022-02-21  566  static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], int num)
d8703554f4dea9 Vinod Koul 2022-02-21  567  {
d8703554f4dea9 Vinod Koul 2022-02-21  568  	struct dma_slave_config config = {};
d8703554f4dea9 Vinod Koul 2022-02-21  569  	struct gpi_i2c_config peripheral = {};
d8703554f4dea9 Vinod Koul 2022-02-21  570  	int i, ret = 0, timeout;
d8703554f4dea9 Vinod Koul 2022-02-21  571  	dma_addr_t tx_addr, rx_addr;
d8703554f4dea9 Vinod Koul 2022-02-21  572  	void *tx_buf = NULL, *rx_buf = NULL;
d8703554f4dea9 Vinod Koul 2022-02-21  573  	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
d8703554f4dea9 Vinod Koul 2022-02-21  574  
d8703554f4dea9 Vinod Koul 2022-02-21  575  	config.peripheral_config = &peripheral;
d8703554f4dea9 Vinod Koul 2022-02-21  576  	config.peripheral_size = sizeof(peripheral);
d8703554f4dea9 Vinod Koul 2022-02-21  577  
d8703554f4dea9 Vinod Koul 2022-02-21  578  	peripheral.pack_enable = I2C_PACK_TX | I2C_PACK_RX;
d8703554f4dea9 Vinod Koul 2022-02-21  579  	peripheral.cycle_count = itr->t_cycle_cnt;
d8703554f4dea9 Vinod Koul 2022-02-21  580  	peripheral.high_count = itr->t_high_cnt;
d8703554f4dea9 Vinod Koul 2022-02-21  581  	peripheral.low_count = itr->t_low_cnt;
d8703554f4dea9 Vinod Koul 2022-02-21  582  	peripheral.clk_div = itr->clk_div;
d8703554f4dea9 Vinod Koul 2022-02-21  583  	peripheral.set_config = 1;
d8703554f4dea9 Vinod Koul 2022-02-21  584  	peripheral.multi_msg = false;
d8703554f4dea9 Vinod Koul 2022-02-21  585  
d8703554f4dea9 Vinod Koul 2022-02-21  586  	for (i = 0; i < num; i++) {
d8703554f4dea9 Vinod Koul 2022-02-21  587  		gi2c->cur = &msgs[i];
d8703554f4dea9 Vinod Koul 2022-02-21  588  		gi2c->err = 0;
d8703554f4dea9 Vinod Koul 2022-02-21  589  		dev_dbg(gi2c->se.dev, "msg[%d].len:%d\n", i, gi2c->cur->len);
d8703554f4dea9 Vinod Koul 2022-02-21  590  
d8703554f4dea9 Vinod Koul 2022-02-21  591  		peripheral.stretch = 0;
d8703554f4dea9 Vinod Koul 2022-02-21  592  		if (i < num - 1)
d8703554f4dea9 Vinod Koul 2022-02-21  593  			peripheral.stretch = 1;
d8703554f4dea9 Vinod Koul 2022-02-21  594  
d8703554f4dea9 Vinod Koul 2022-02-21  595  		peripheral.addr = msgs[i].addr;
d8703554f4dea9 Vinod Koul 2022-02-21  596  
d8703554f4dea9 Vinod Koul 2022-02-21  597  		if (msgs[i].flags & I2C_M_RD) {
d8703554f4dea9 Vinod Koul 2022-02-21  598  			ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
d8703554f4dea9 Vinod Koul 2022-02-21  599  					    &rx_addr, &rx_buf, I2C_READ, gi2c->rx_c);

I feel like the "rx_buf" pointer needs to be set to NULL on each
iteration through the loop.  Otherwise we use the previous rx_bug for
the next msg[i].

d8703554f4dea9 Vinod Koul 2022-02-21  600  			if (ret)
d8703554f4dea9 Vinod Koul 2022-02-21  601  				goto err;
d8703554f4dea9 Vinod Koul 2022-02-21  602  		}
d8703554f4dea9 Vinod Koul 2022-02-21  603  
d8703554f4dea9 Vinod Koul 2022-02-21  604  		ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
d8703554f4dea9 Vinod Koul 2022-02-21  605  				    &tx_addr, &tx_buf, I2C_WRITE, gi2c->tx_c);
d8703554f4dea9 Vinod Koul 2022-02-21  606  		if (ret)
d8703554f4dea9 Vinod Koul 2022-02-21  607  			goto err;
d8703554f4dea9 Vinod Koul 2022-02-21  608  
d8703554f4dea9 Vinod Koul 2022-02-21  609  		if (msgs[i].flags & I2C_M_RD)
d8703554f4dea9 Vinod Koul 2022-02-21  610  			dma_async_issue_pending(gi2c->rx_c);
d8703554f4dea9 Vinod Koul 2022-02-21  611  		dma_async_issue_pending(gi2c->tx_c);
d8703554f4dea9 Vinod Koul 2022-02-21  612  
d8703554f4dea9 Vinod Koul 2022-02-21  613  		timeout = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
d8703554f4dea9 Vinod Koul 2022-02-21  614  		if (!timeout) {
d8703554f4dea9 Vinod Koul 2022-02-21  615  			dev_err(gi2c->se.dev, "I2C timeout gpi flags:%d addr:0x%x\n",
d8703554f4dea9 Vinod Koul 2022-02-21  616  				gi2c->cur->flags, gi2c->cur->addr);
d8703554f4dea9 Vinod Koul 2022-02-21  617  			gi2c->err = -ETIMEDOUT;
d8703554f4dea9 Vinod Koul 2022-02-21  618  			goto err;
d8703554f4dea9 Vinod Koul 2022-02-21  619  		}
d8703554f4dea9 Vinod Koul 2022-02-21  620  
d8703554f4dea9 Vinod Koul 2022-02-21  621  		if (gi2c->err) {
d8703554f4dea9 Vinod Koul 2022-02-21  622  			ret = gi2c->err;
d8703554f4dea9 Vinod Koul 2022-02-21  623  			goto err;
d8703554f4dea9 Vinod Koul 2022-02-21  624  		}
d8703554f4dea9 Vinod Koul 2022-02-21  625  
d8703554f4dea9 Vinod Koul 2022-02-21 @626  		geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
                                                                                                                    ^^^^^^^
Uninitialized variables

d8703554f4dea9 Vinod Koul 2022-02-21  627  	}
d8703554f4dea9 Vinod Koul 2022-02-21  628  
d8703554f4dea9 Vinod Koul 2022-02-21  629  	return num;
d8703554f4dea9 Vinod Koul 2022-02-21  630  
d8703554f4dea9 Vinod Koul 2022-02-21  631  err:
d8703554f4dea9 Vinod Koul 2022-02-21  632  	dev_err(gi2c->se.dev, "GPI transfer failed: %d\n", ret);
d8703554f4dea9 Vinod Koul 2022-02-21  633  	dmaengine_terminate_sync(gi2c->rx_c);
d8703554f4dea9 Vinod Koul 2022-02-21  634  	dmaengine_terminate_sync(gi2c->tx_c);
d8703554f4dea9 Vinod Koul 2022-02-21 @635  	geni_i2c_gpi_unmap(gi2c, &msgs[i], tx_buf, tx_addr, rx_buf, rx_addr);
                                                                                   ^^^^^^^^^^^^^^^
Using old tx_buf or uninitialized tx_addr.

d8703554f4dea9 Vinod Koul 2022-02-21  636  	return ret;
d8703554f4dea9 Vinod Koul 2022-02-21  637  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

