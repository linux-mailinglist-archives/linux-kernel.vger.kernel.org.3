Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0B50BCB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378187AbiDVQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378340AbiDVQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:17:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0595E750
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:14:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MDWik5020622;
        Fri, 22 Apr 2022 16:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DK8bprxgGrPAfbEfsAN+FqrSPVaAYLxfoxGXahGQE0U=;
 b=mqugHApmpEC2HMBw+k58gJIOcg5pa6UshLKUXyYN6AE6BHYW2gE8GF2nxwex98MKgIPh
 DdiELQBWGfifgHbHPrqRIOmoTE3UNS5TB201trLWOSdBRqVsBg0eb0QrCFeSHHcnwgof
 BRalqK5ENk2SttDQtuBFuYlYSougPNlEHEMlbznz6ogrwOed21QqKe81zWWg+MsoTL0F
 5cYYv5niAPpi70Zp5+MXNT9F8U2Mr2KsTsVb0DzOXFn3f0pWj8Eri8wtrpQr5wnP5Nol
 4Q9qTSpiCK1kOgrq8mFqbTtz2I5dSTLJRepA6ZAyeUBCiGr+hkVHhOVm30+8QhkMiyhN Qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1f7m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 16:13:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MGAAhT030750;
        Fri, 22 Apr 2022 16:13:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fkw6xqeqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 16:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7f5MsmVmYmlK6AvKUevxPN9TjjoMOVMWNCn6wrsTWEmPda0WF7vqieTAc2RAH46EDRQgDdlbV4XLeUVNzLGdHZRTuTzxlZOABv+v+TOyk6PsVqhiVWnFK98rulgesJOkQgKMnjwl6i/1ev/mecPnOyA+1w9sZRCQjSrc5EDqIJd0rSp1XhkDwSIZm+K3gK+G/XIVrgx+x5GEvL4zR4e4sFZnPMuMnDKfspkoIYCxNOHoyY55plwPMDo2ivg7OPr6l/J/0DuKif53thV0Ay3KcPylxviW1AERbcQwa0sTcAQ7XWeUcOEyN9L6/2Rvye5e1FGvkTJ6LJ8ZAJgh3cHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK8bprxgGrPAfbEfsAN+FqrSPVaAYLxfoxGXahGQE0U=;
 b=ca/IR9c6p8oBBkR9SlMTA/TwIL9IFSK4mZTLbuIXchXYoNJkyX7lQSr/giexibtnmNfHEWjkdUyEKvtvxncYzIz81xvu+KwkzrpdHOP7QWMakaVqCshJRfRAhQmAt4c67NguO6/pO7Ra1XZ6xs4Cow2iKoGxU21EsjkBBmifuOl2zK0R34Eg6n8Uy7QqqJlEAzEGa4SRDnTUCDLPwQpjooAWPEghKNbjZvzbObKOFuJ3PB8p82xAnlEhoU7UOLjAoDvV7QDI5W2VAnA05+LBTBIdXKinslOW+8vmcAbn0kRFbgy3dOdiDe/XPl6v3qloriYSGCMsa9XcYqcZvmfuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK8bprxgGrPAfbEfsAN+FqrSPVaAYLxfoxGXahGQE0U=;
 b=gc6HoQjkM+N+ak02CpvDtihcgO1nN/lcFa5QRhC1RdTtOXzbfG165y3cygpVTwkwFJ9biquA75EefhfPF3Qu5xTV6jlRnH4Z9IC6kh87zvaIYpWwjirZQJZY3hcGmo6rfrj9J0o5vMoZUJ71n1czqZOIfrhRKm2BLrCQ9S1oVVU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1243.namprd10.prod.outlook.com
 (2603:10b6:4:f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:13:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 16:13:49 +0000
Date:   Fri, 22 Apr 2022 19:13:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 1/7] staging: r8188eu: remove unused member
 free_bss_buf
Message-ID: <20220422161335.GL2484@kadam>
References: <cover.1650392020.git.jhpark1013@gmail.com>
 <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
 <32587233-0ff6-ed0f-b873-cd4f797005a9@gmail.com>
 <20220420115534.GF2951@kadam>
 <20220420144834.GA1313590@jaehee-ThinkPad-X1-Extreme>
 <20220420173926.GE2969@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420173926.GE2969@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0087.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9316b8c9-fb54-4063-303a-08da247b1565
X-MS-TrafficTypeDiagnostic: DM5PR10MB1243:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB124345E8B72F3C38884DFC0E8EF79@DM5PR10MB1243.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pcVyUGh1+hKpM06ArmqrXTLo436GVPhxEGc9VEnbIEizunuS3kjSoHeYXKelhmbvwbVkdrMoxQ8y3kLKpZNFIl+eM/CGv3fCH5JuSF0wXX+BoGdbIpKGT84Nc9Bg8xjKvKa5aiHbmMmvOgxvQWe2QTt1Wc6vTNFqjsTftUo4BzAkWaZW1qcHLQ0LBHVXbImg481rYdMVVipGzGOr+8QjRb344YQVhSSmBBnhmcH0QZUx79ms/eiaxFQsWG1M5Vdq2vkxY+Vmuhf14o8W97W7/B4hS1pB989aoO3Vq4tLr0eB5XtPbI8zIO5Ujm2nKJbivbBlww3+gD/T6iKU6TIjXe92ICI5vMtnTYpX16RvK7brluEdlzZgtyuPXDb7kPG4lWyoEUkq9+8cGTFrfxJahYMEeSZkQoWH0+aA/APdFL7JGuih9V37IKFdOcgIzWuhh0vwRwOhNsejIvvgT9t+N4Ln97ohmRSg42KbJRIuR0cdcmBD1YYNNh0pvZjgJiM8JazTMOKOWL9/xQeaLxWgeYaOu6BFuBmKewK50WTfCWfZPXTJJ8dc9gmWdyh60m/nzJGVitZrp1LK/dUWds+2o2ZVOuwrQzdk/GppkMxe7bfawbgo3ZGj4LoFWunjd7swgBKn3nCPxp+QpYHm3g2RrLN0S1F8pFSfux7KW5hBzDd1/j+IAD2zq879qqjihR9SmsJkQTEm2zIOQ1okwGoCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(2906002)(186003)(316002)(9686003)(1076003)(6512007)(508600001)(8936002)(26005)(6916009)(66476007)(66556008)(66946007)(6506007)(8676002)(83380400001)(4326008)(44832011)(6666004)(33716001)(38350700002)(38100700002)(86362001)(5660300002)(33656002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EmM03VncJ5iuutLrBvDuvc/jLDmOc7UQsug3z8a7cGxXDXbz+/6DuV7lCxw?=
 =?us-ascii?Q?ZLzDwz6t9CdkK9Fj8i/xGkR5fCpcBrhr5oCOjc567zmO46l1lENf17CWUYxg?=
 =?us-ascii?Q?62YFaPO7ZoiaHHLEvUbKHZknz8QGrDKcSRLUFngmEk3dbfn/PfZ03BH6kY4S?=
 =?us-ascii?Q?aReUL8EfeTOqDzwLHp4dR2VQEdsIbxII7XqaMOaKr05euqBGoh/wJ9u3qnES?=
 =?us-ascii?Q?OS+vpUmK5Xhmj+1/VosBsblkbmIzVPdyaFNS2SvpzjA9nJluUuB8Cy5PKWBQ?=
 =?us-ascii?Q?s/bOt9IQtipsc6/4OscQqs34KIID3ymTsiIwP6XM3N4QNGYGKtr53tsyuRtL?=
 =?us-ascii?Q?BwKlqETkU+5PbBQGcMVMKPREw6EV/fFy3LwOCixjeLLNu5qoTLB3zh9RkuAc?=
 =?us-ascii?Q?kyZmo8qeS9VU7rGG6bktRKmzERfNmtMQMoeNb2EE6GYPYo5o39l6uIRWSKmb?=
 =?us-ascii?Q?2ojF/dQhaSZJArNLM8iTOvAOXe7w2FxeMwtzyqiSW0DPNMrH/HCFeuvCVGlK?=
 =?us-ascii?Q?JrHMsEtxGNh3hrJq0GCS6ujA510LOpvw/xmda8XxZssIcRH6h0RhnZNm8tFb?=
 =?us-ascii?Q?Gba4XwO30kmeMTii7Jq4HNavxQ17JD6vmZobIcqjebKqKZro55MhUX/pK0am?=
 =?us-ascii?Q?WNCS9qBObHBSGmDzQsYkR+zo27UHKMDwagj5+03LNflwQ+DK/NKmPIjB03d6?=
 =?us-ascii?Q?BqpSMaVuudR9x4Ku+2NsVgiHZCDpzP2dFFnUkArU7OZuz0Gx6+rIRhhmSTor?=
 =?us-ascii?Q?OaMXM5JTy27kwz4DeMhhuXhEWpNYZ1157gS0pmiWvytvclddef+wL24ReJ+d?=
 =?us-ascii?Q?GE9FQTh2Jrb7jc5HQVu0LWO7w89hG6baZvZpdU2PGqNngjvhTlzGwTkrAf+D?=
 =?us-ascii?Q?tYvmLyRytKXrIo2yKaa00EmHL7v90xang2VVBbpMC/ZHkEO7MaxaiQInisMF?=
 =?us-ascii?Q?d1yfzB7LU41OJroblQwr0Ifa0ZShi2DCgv63Yza1k86QoQkbsQ1v1MKJECMX?=
 =?us-ascii?Q?wNNcQtkON7lLKiBHNNizrT7BeWyofcHeb9qyKWMx2U0AS5jcZ0Jb+w0tkHas?=
 =?us-ascii?Q?z5HlGE2xzC4nZwE66zpTZ+q/k4D4M2WqIfe/zsVDlitCcukC8nJlk5ijoDtB?=
 =?us-ascii?Q?PHsJkUeXfTPFdPotOEVhx9kIBNjSJeGYIyxQoSQbfw6PAUjvtPcWn9Kpy2ud?=
 =?us-ascii?Q?pZ60qxEoH+GGbiLcW8Lr0Dc2UwjEp2xtFR59xKoPEEQXTvlEYzMYyxV2LAqF?=
 =?us-ascii?Q?kYHCuu5YiN8uaiDJ3RXYiosvImbfsyFpUyhWTnld4YpIydjPV1zNFNjryqlL?=
 =?us-ascii?Q?8fU1vvpU8xEjp9EJBENuNivCTV4Dy8PoRA8ItQ/slgHAVQk284jO1CTmwVQL?=
 =?us-ascii?Q?fBPkn5jXJSl94BueX5XRO14SXggChnJ7lwY45shFZT4XL4y7cw8D3+mk9G07?=
 =?us-ascii?Q?1Xa7HtCtBgd2wXcjrWOp0D8uj94ImmCyUAJRgBRzQl77ORTLvFKl6CM5ID9e?=
 =?us-ascii?Q?WEY12dg2cGPZP5bBi1JJnap5hsRmkplcy88sOo7ulW+IsjP4Ekj/GyVw4szy?=
 =?us-ascii?Q?4O1AncjCgb+VVUY1W8IxZm3vapHmfoTw/E4rKGnAactmDFoop4TysQQU0T0/?=
 =?us-ascii?Q?q9icT3s3jeojOUCPhkQDskQRXZnlhi5j1NS1IJH8+RskcReInZpZDZAQRTI7?=
 =?us-ascii?Q?+sbsrtRS9loNe582RYXUwIbMQBMCTCROO5rrMn66oIdKjmsnZnNB6Oi6Sszz?=
 =?us-ascii?Q?kcP3UiXi0oRW7cpycf+D0pZd5Fw/GaM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9316b8c9-fb54-4063-303a-08da247b1565
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:13:48.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ew+zRbiB3NjAHNYGY7QZ41cFVWn6xQPbe6ONX/FcOdOHFi+YEAirsgpLj5Gl68Fop/Z/8AWzBL0L7qC1zCxQNTFplix6o/8r/6RoBpatlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1243
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=471 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220072
X-Proofpoint-ORIG-GUID: X_GIpG_cwfvtGx3Wn97za845gWCweFwG
X-Proofpoint-GUID: X_GIpG_cwfvtGx3Wn97za845gWCweFwG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:39:26PM +0300, Dan Carpenter wrote:
> > >    Another is idea is that when you have pnetwork++ and it's a NULL
> > >    pointer then print an error message.  Or even potentially NULL.
> > >    There are various heuristics to use which mean that "A reasonable
> > >    person would think this could be NULL".
> > > 

I wrote the check but it turns out none of the results are that
interesting after all.

drivers/atm/horizon.c:1844 hrz_init() warn: incrementing NULL pointer 'mem' rl='0'
drivers/scsi/qla2xxx/qla_iocb.c:665 qla24xx_build_scsi_type_6_iocbs() warn: incrementing NULL pointer 'cur_dsd' rl='4097-ptr_max'
drivers/scsi/be2iscsi/be_main.c:2686 beiscsi_init_wrb_handle() warn: incrementing NULL pointer 'pwrb' rl='0-u64max'
drivers/net/ethernet/nvidia/forcedeth.c:2304 nv_start_xmit() warn: incrementing NULL pointer 'tmp_tx_ctx' rl='0-u64max'
drivers/net/ethernet/nvidia/forcedeth.c:2482 nv_start_xmit_optimized() warn: incrementing NULL pointer 'tmp_tx_ctx' rl='0-u64max'
arch/x86/boot/cmdline.c:66 __cmdline_find_option() warn: incrementing NULL pointer 'opptr' rl='0,4096-ptr_max'
arch/x86/boot/compressed/../cmdline.c:66 __cmdline_find_option() warn: incrementing NULL pointer 'opptr' rl='0,4096-ptr_max'
arch/x86/lib/cmdline.c:84 __cmdline_find_option_bool() warn: incrementing NULL pointer 'opptr' rl='1295896293336907776,2458024882201202688,3889929980400390144,6141874131669250048,6180548506814574592,6275458169940578304,6344884530654208000'
arch/x86/lib/cmdline.c:167 __cmdline_find_option() warn: incrementing NULL pointer 'opptr' rl='0-u64max'

regards,
dan carpenter

