Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84FF57FC27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiGYJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiGYJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:16:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C46F1583D;
        Mon, 25 Jul 2022 02:16:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P8xApp011449;
        Mon, 25 Jul 2022 09:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=jLsOlYxggPYlZOU8V1nimy98D9WZp+rj659uCjvrJT0=;
 b=nBKCq/hZcwbYt7574kty84BNlXoD9kbVjHbjbjloWmsiqsUvoScqfh87uJZOigQ1PUgl
 MbHe5CE+oLBd+F0rzSdMlJA3HstOJx3fui6V/5y7Osjq5Xo9OS9+9OJfxjoRAI7X+vKD
 LN3iHcpyDe5OaDV7RvP7NpZ5YkUE7ou1eHsqm5MWqwQ3E9zlqHkQOqgMIxS5vxbGMDsb
 bUS6RbliGmGQgh/eetnL5jS657GtTa993iloID+zTMs+wHP9sbptfshTxFZggEDxP1OQ
 J0yyAOxWEyX6c1NqZ2CndyZU/iWMbMBzKOb7+24TY5zO4fbxoTwvia5q+iIzV5+RMP9h 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940jqwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 09:16:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26P8wJUj006430;
        Mon, 25 Jul 2022 09:16:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh659ysjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 09:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf6MP78ayvO07iyrk5UMW/MZ8JQyG/buJmErTzFJQBe9e7rYyXQkKwLyzUrUh6iGksGczs9PXCrTezY5nmeRUdA2mOlcKnXX3IkvKrXpXTJbL1w7h+3KoPQUv4OtACvGTWoevtp+BZjd+V2w2MuwV5JabZulrTwBvpRqXBd/G3cfDKBfJmyEAzAL2Frphf1+eQVeJ7AUqpDNsFGEgGe3nJfrF9okknD3lRmr5wmxET9LdBsz2cseGGRNe9j1Z78sLhcab64JULLQDLSfpAS+4JZJeLaDxULJyrDVPjR6HbxJoEjCkGJfrGDJtoYdR1aKXctuOhGxxnkVNliE0rq9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLsOlYxggPYlZOU8V1nimy98D9WZp+rj659uCjvrJT0=;
 b=gWrPSgEsUa0SNYSaGFueN+CyAFgkvz2ECiUumX4b/PdCOaVqApNxnU5Ar9drItvnnz8bJBMXX1AZsUOl4yMrU4utzSTk44FYGeV7MHZsnYTavjXi3q9nLKxeq5DQvcz7Ce92G4dBwuI8trd+D2G5vZdkVYiu47jaEfc29mQ9rRjtonl3uDOJOtexSUMdUv7j5zxDp/lE/+VtUz5uCj/HwLzekOGPfsIbJydFNwfPHcz7h0rWC5NiganmMVdFMm879c3X6brHgdJEbLmQCcMcj25O5E/vyZhOgEv4raA1krsdxDDXrJ/qD7PQ1PKGqxkl59ydmLJqX/4V4G4jMIrF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLsOlYxggPYlZOU8V1nimy98D9WZp+rj659uCjvrJT0=;
 b=QN4WYckTbposTLbRPnFzTNisclb5fX9Qw0AfDm9+rjhY/WE64EoJa/eg91oLbJczNGplyvQSXbz1wekbqfyInMa6mBdtqcYRODQ12pomzm8sMPzzDce5Tt0hACb7ZGxIBl2hS4ZpmmuLJU9Rq65W/wSR0Fb/2sIeVVV3Mztabls=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2491.namprd10.prod.outlook.com
 (2603:10b6:5:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Mon, 25 Jul
 2022 09:16:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 09:16:27 +0000
Date:   Mon, 25 Jul 2022 12:16:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Can Guo <quic_cang@quicinc.com>,
        bvanassche@acm.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        linux-scsi@vger.kernel.org, kernel-team@android.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Message-ID: <202207231904.OkiLJTiT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 352632eb-cdb8-47c9-46fc-08da6e1e5a0c
X-MS-TrafficTypeDiagnostic: DM6PR10MB2491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAZDj055ST4sYBp2t6TXBJleq9NDyjID8SPJNxweOhzls8lmqW1/V6MJu0dzwHTd2n86UuECUYUuRUHffNZEcfwJs1TX3HBv49k0AHFBoJDCw8NbArS/QgfXa9605URrlM3ohfuA6YmFJbkCNscMxhl8Vbah3/ZcNeDgwKeDdWSuUxR95HGNL/RXU2n4Xkcm3oonLAjEFVcQA+E9HdXC6zUd32PZCeH7iny5RxhJp0JBz6GFjYaMBoQ6dPgvJlDOnpi7XR3/09ZcM5z3FDdroBx+Dvhr5EPwyzorkT2rtulilgDZm/gEcNP5NK/BkBOPdgPHw87ecpGlfpkimBDr3bVdQGgcj5lJfrDED0co96GTn//CKjo3TO+TYcgVi/ebaQFETmleAcdeTD/ho+WIm5GFstxwgxhoeUAkAlatbExankiIbpVa04R9DqMvRr1AzrrEyUTvYjTigdr8kG82omuiMXJkcaGlmd03532Ylm/L7aiYHeahpfK9/npUxSAZFvQE7/qX9icwSLZQLnTHL3THYpVQvl5E3BH5k8s9NPeq0I03M+RB25FDiC0h6q7fks5MmOjMjiiC8f6HWIBkU3emE3OpviFCSy2PWjLk16Scd7YIyAQ2+/ejmI3n6G7nsc4rvcBvHtWo8Ht2te8izcEJ0DwWaJKbFx+CE7wgIPVfin9hPNprb+mZEKDtT1+jFNsGN54Zpx07t+nSOv/pxkXVhzUCYT/WwW9DNzkudBco3AGX4yIkLcvF6D/boA30sSBVkUTpFbqcfRsOfKGYY8aS+BXR9f7sD7suBm/Vd9JhcjhoJH+IziRh7ge6hsbSyVECPT3Asj3/jhW44FB/9ktIVuFgNDQCt8KZ3+PrgBVt7FHxO0ulnSi7LQ7tTUshdHgXXjI1r5GCdkxICCmOLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(6506007)(52116002)(9686003)(6512007)(26005)(6666004)(186003)(5660300002)(1076003)(8936002)(44832011)(4326008)(8676002)(30864003)(2906002)(7416002)(478600001)(36756003)(86362001)(4001150100001)(6486002)(966005)(41300700001)(921005)(38350700002)(38100700002)(83380400001)(54906003)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGDVGbJ50mij6GbBtS8pmNLw+lzrtSSOsr0jxx+2l8vR30gpuCs23U7XbsJk?=
 =?us-ascii?Q?lSq6xVRoRxfQm6F8fPmnofebOoBHgY7fk133tORA3WeNpRCbrmnZaUEPZ1yN?=
 =?us-ascii?Q?2w1YhmL9Q/ZU9rejE402KRkuWQBEn7OHMUoOU0Skv/TGTMi1qJ7SiTeT8S8a?=
 =?us-ascii?Q?4YS/2gmxCGTDxkjhQ0acuwd0Jk7vtcq2mVD8AwkqranIZ5i76IV9kOyxW4JA?=
 =?us-ascii?Q?6n//5629XqxAxnGayuxJ69XPDRlTXVToBnwfMQYMXB7bPJiuEb7dlUu06lcD?=
 =?us-ascii?Q?NPv0AZHUV5Fy5hKSwXQ7eE2bjvUKMKwP+ASI8+38ru2fjWHbzT5kfOVoO8sc?=
 =?us-ascii?Q?WGPUcc/ejle9Z0PViSw8Q+yyXebxZ1mYulQqHJ50D5SChIl7Nc0p0i9B7+sE?=
 =?us-ascii?Q?gDioeAeeKgwXwFXXWwxhcjerhQZ4WKe81U54QnerWgrPd9QCAHdqhAPsxZmH?=
 =?us-ascii?Q?oUVXGEBKJ+IlUOWSBkZNkVAFQ7Pk6xZcG8usnrC/w8LOd26T6ghVzvgG4bNJ?=
 =?us-ascii?Q?3usgfgpsK1uPpO44mlzNuhyXZemFxuQq4jUqPYmvEvhBzNn+EbIVH8gk5rCF?=
 =?us-ascii?Q?0RVwY8utzwvVM45r6FO/BJ1hRstfHH0tRq1oG3rtlrGiGeD2WtCXAvAisfC8?=
 =?us-ascii?Q?zaSLU0UUEg3O5fnve2jxr4TP5WiPu9qKAigURiwcoIG7WUSFOvhZA4q0resT?=
 =?us-ascii?Q?wsUSSAhwsN2nO2Ts3WHxDxKUiPlDGwvPvv/HzANGYrk6nqvMnRo31nriWAra?=
 =?us-ascii?Q?wtcsFNo98LFZkgfawYe4eQHmyZaooFGqOK/9Wzkzhz49B8IlYNTtZCxxW26I?=
 =?us-ascii?Q?RVukeXyvKrGA9u+8okSMPNKFTgA/n2YHJROaaoYR2ZzrzEih1BND9vWFHD4f?=
 =?us-ascii?Q?hVEgU+2PNJwJD6loDaNBtinPRKt+pYNVHdhdj3h2PpoBaC4VGQsiQBg9eVu0?=
 =?us-ascii?Q?la1KeS0PrtbSC/JLm15ypMeHVze+XJzqPO78VHIPFYYRB7R6r7/mqsx+dVRP?=
 =?us-ascii?Q?gStGWWdH5oiM+SvJz1zV9GH/xbvr+fYhfTEofxAZ728IrQftM7lhlj24NhRo?=
 =?us-ascii?Q?Ok1Trc7co9Vxhz+dySwDp5/d4ua96AV83rQNLIZBXJtqiE8rjLXIgusHa4Qm?=
 =?us-ascii?Q?fiebqiIPDnghWzer2YURyzT0mtr6rVsjSDkB9dpb2z7micf8zM4xamwuKIW5?=
 =?us-ascii?Q?t+3NZNSZ40+mZrp7t//gcyWQ/J0eu5uiyg9YLSNAY03JWDyJ9jwhk1Aqj4Nj?=
 =?us-ascii?Q?IJkvam3PjEXPyVO9rSTerQx+rdtQRtelIsOYhYSW+ndHFtz/POgFQd+4jKzD?=
 =?us-ascii?Q?u+GirydSMsCMu6Ozso+No2rvhAlNlhhYn1yNjgx5jnT+2wqEzAPmKZ4WBfJQ?=
 =?us-ascii?Q?OP8U+8XAM9X1GqwEx/Sl2s+m53+qyAHb/83j/RL9sBhkiqNQm6MLcrfUw9E4?=
 =?us-ascii?Q?ANPI4jWbUWSmpO8lMIjzPhAlCgsFKLvwHLfHMkg0g1grSDxAGrW5KKndMB0W?=
 =?us-ascii?Q?APKhH2Gw4JTfIHeZEhm4jtJosYxZEMkLIsTgqkxVSJgvjHnUPuV19M+ysYA6?=
 =?us-ascii?Q?+UpGHkEeoX54qhbW8yRZ57NmB2lkTlpwX0qPb4ko385EeQTd8xzfAXFr2sFc?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352632eb-cdb8-47c9-46fc-08da6e1e5a0c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:16:26.8924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NEDZo3tshfK5bJ5ePGCYMRzJqG7nU6ks3WNZVPix2wzgzR+1/yOibsViOU8GtueZjf4RhMZYsIi9/bti7nXnKBKFrU62N5SDdxTdeuIzWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_07,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250039
X-Proofpoint-GUID: 2C4aP4ia6YlRTy6Fw8-pxt8QWEpR-YOf
X-Proofpoint-ORIG-GUID: 2C4aP4ia6YlRTy6Fw8-pxt8QWEpR-YOf
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Can,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Can-Guo/UFS-Multi-Circular-Queue-MCQ/20220719-150436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: arc-randconfig-m041-20220718 (https://download.01.org/0day-ci/archive/20220723/202207231904.OkiLJTiT-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/ufs/core/ufshcd.c:2887 ufshcd_queuecommand() error: uninitialized symbol 'hwq'.
drivers/ufs/core/ufs-mcq.c:315 ufshcd_mcq_config_resource() warn: passing zero to 'PTR_ERR'
drivers/ufs/core/ufs-mcq.c:334 ufshcd_mcq_config_resource() error: potentially dereferencing uninitialized 'res_mem'.
drivers/ufs/core/ufs-mcq.c:330 ufshcd_mcq_config_resource() warn: missing error code 'ret'

Old smatch warnings:
drivers/ufs/core/ufshcd.c:5360 ufshcd_uic_cmd_compl() error: we previously assumed 'hba->active_uic_cmd' could be null (see line 5348)

vim +/hwq +2887 drivers/ufs/core/ufshcd.c

7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2792  static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2793  {
4728ab4a8e6490 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-07-21  2794  	struct ufs_hba *hba = shost_priv(host);
3f2c1002e0fcb6 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-08-09  2795  	int tag = scsi_cmd_to_rq(cmd)->tag;
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2796  	struct ufshcd_lrb *lrbp;
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2797  	int err = 0;
2b7356bcd24efd drivers/ufs/core/ufshcd.c Asutosh Das        2022-07-19  2798  	struct ufs_hw_queue *hwq;
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2799  
eaab9b57305496 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2800  	WARN_ONCE(tag < 0 || tag >= hba->nutrs, "Invalid tag %d\n", tag);
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2801  
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2802  	/*
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2803  	 * Allows the UFS error handler to wait for prior ufshcd_queuecommand()
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2804  	 * calls.
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2805  	 */
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2806  	rcu_read_lock();
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2807  
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2808  	switch (hba->ufshcd_state) {
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2809  	case UFSHCD_STATE_OPERATIONAL:
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2810  		break;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2811  	case UFSHCD_STATE_EH_SCHEDULED_NON_FATAL:
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2812  		/*
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2813  		 * SCSI error handler can call ->queuecommand() while UFS error
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2814  		 * handler is in progress. Error interrupts could change the
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2815  		 * state from UFSHCD_STATE_RESET to
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2816  		 * UFSHCD_STATE_EH_SCHEDULED_NON_FATAL. Prevent requests
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2817  		 * being issued in that case.
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2818  		 */
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2819  		if (ufshcd_eh_in_progress(hba)) {
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2820  			err = SCSI_MLQUEUE_HOST_BUSY;
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2821  			goto out;
d489f18ad1fc33 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-10-08  2822  		}
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2823  		break;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2824  	case UFSHCD_STATE_EH_SCHEDULED_FATAL:
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2825  		/*
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2826  		 * pm_runtime_get_sync() is used at error handling preparation
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2827  		 * stage. If a scsi cmd, e.g. the SSU cmd, is sent from hba's
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2828  		 * PM ops, it can never be finished if we let SCSI layer keep
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2829  		 * retrying it, which gets err handler stuck forever. Neither
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2830  		 * can we let the scsi cmd pass through, because UFS is in bad
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2831  		 * state, the scsi cmd may eventually time out, which will get
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2832  		 * err handler blocked for too long. So, just fail the scsi cmd
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2833  		 * sent from PM ops, err handler can recover PM error anyways.
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2834  		 */
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2835  		if (hba->pm_op_in_progress) {
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2836  			hba->force_reset = true;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2837  			set_host_byte(cmd, DID_BAD_TARGET);
35c3730a965722 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-07  2838  			scsi_done(cmd);
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2839  			goto out;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2840  		}
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2841  		fallthrough;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2842  	case UFSHCD_STATE_RESET:
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2843  		err = SCSI_MLQUEUE_HOST_BUSY;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2844  		goto out;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2845  	case UFSHCD_STATE_ERROR:
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2846  		set_host_byte(cmd, DID_ERROR);
35c3730a965722 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-10-07  2847  		scsi_done(cmd);
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2848  		goto out;
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2849  	}
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2850  
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner       2017-02-03  2851  	hba->req_abort_count = 0;
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner       2017-02-03  2852  
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala    2014-09-25  2853  	err = ufshcd_hold(hba, true);
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala    2014-09-25  2854  	if (err) {
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala    2014-09-25  2855  		err = SCSI_MLQUEUE_HOST_BUSY;
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala    2014-09-25  2856  		goto out;
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala    2014-09-25  2857  	}
2dec9475a4028b drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  2858  	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
2dec9475a4028b drivers/scsi/ufs/ufshcd.c Can Guo            2020-08-09  2859  		(hba->clk_gating.state != CLKS_ON));
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala    2014-09-25  2860  
2b7356bcd24efd drivers/ufs/core/ufshcd.c Asutosh Das        2022-07-19  2861  	if (is_mcq_enabled(hba))
2b7356bcd24efd drivers/ufs/core/ufshcd.c Asutosh Das        2022-07-19  2862  		lrbp = ufshcd_mcq_find_lrb(hba, scsi_cmd_to_rq(cmd), &hwq);
2b7356bcd24efd drivers/ufs/core/ufshcd.c Asutosh Das        2022-07-19  2863  	else
a45f937110fa6b drivers/scsi/ufs/ufshcd.c Can Guo            2021-05-24  2864  		lrbp = &hba->lrb[tag];

hwq not initialized on else path

2b7356bcd24efd drivers/ufs/core/ufshcd.c Asutosh Das        2022-07-19  2865  
5a0b0cb9bee767 drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  2866  	WARN_ON(lrbp->cmd);
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2867  	lrbp->cmd = cmd;
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2868  	lrbp->task_tag = tag;
0ce147d48a3e33 drivers/scsi/ufs/ufshcd.c Subhash Jadavani   2014-09-25  2869  	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
51d1628fc45727 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2022-04-19  2870  	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba);
df043c745ea149 drivers/scsi/ufs/ufshcd.c Satya Tangirala    2020-07-06  2871  
3f2c1002e0fcb6 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-08-09  2872  	ufshcd_prepare_lrbp_crypto(scsi_cmd_to_rq(cmd), lrbp);
df043c745ea149 drivers/scsi/ufs/ufshcd.c Satya Tangirala    2020-07-06  2873  
e0b299e36004f5 drivers/scsi/ufs/ufshcd.c Gilad Broner       2017-02-03  2874  	lrbp->req_abort_skip = false;
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2875  
09d9e4d0418766 drivers/scsi/ufs/ufshcd.c Avri Altman        2021-10-30  2876  	ufshpb_prep(hba, lrbp);
2fff76f87542fa drivers/scsi/ufs/ufshcd.c Daejun Park        2021-07-12  2877  
300bb13f5c7b1d drivers/scsi/ufs/ufshcd.c Joao Pinto         2016-05-11  2878  	ufshcd_comp_scsi_upiu(hba, lrbp);
300bb13f5c7b1d drivers/scsi/ufs/ufshcd.c Joao Pinto         2016-05-11  2879  
75b1cc4ad63afa drivers/scsi/ufs/ufshcd.c Kiwoong Kim        2016-11-22  2880  	err = ufshcd_map_sg(hba, lrbp);
5a0b0cb9bee767 drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  2881  	if (err) {
5a0b0cb9bee767 drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  2882  		lrbp->cmd = NULL;
17c7d35f141ef6 drivers/scsi/ufs/ufshcd.c Can Guo            2019-12-05  2883  		ufshcd_release(hba);
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2884  		goto out;
5a0b0cb9bee767 drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  2885  	}
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2886  
2b7356bcd24efd drivers/ufs/core/ufshcd.c Asutosh Das        2022-07-19 @2887  	ufshcd_send_command(hba, lrbp, hwq);
                                                                                                               ^^^
Sent


7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2888  out:
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2889  	rcu_read_unlock();
5675c381ea5136 drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-12-03  2890  
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  2891  	if (ufs_trigger_eh()) {
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  2892  		unsigned long flags;
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  2893  
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  2894  		spin_lock_irqsave(hba->host->host_lock, flags);
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  2895  		ufshcd_schedule_eh_work(hba);
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  2896  		spin_unlock_irqrestore(hba->host->host_lock, flags);
88b099006d83b0 drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-09-17  2897  	}
c11a1ae9b8f65e drivers/scsi/ufs/ufshcd.c Bart Van Assche    2021-07-21  2898  
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2899  	return err;
7a3e97b0dc4bba drivers/scsi/ufs/ufshcd.c Santosh Yaraganavi 2012-02-29  2900  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

