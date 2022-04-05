Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BDF4F4EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836066AbiDFAeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384584AbiDEPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:14:58 -0400
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1773E5E9;
        Tue,  5 Apr 2022 06:29:57 -0700 (PDT)
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2355FnqV025225;
        Tue, 5 Apr 2022 08:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pps1;
 bh=zkCrIOak8zDCz2p2CL07p7jkf0bjcqO+SO7njU8RzKE=;
 b=e2+gIrchZIkL01G4+a5Cpl68JxDQyI1kI0HNd+dqY1D7FTDvSSxwpAhwYcMigTQPNvbb
 Zq0uFNn42yXGwN4tYmKACHKkxbGl4nOzwV8nj14e58WTv7ZW4IknWBwmjYNyeLQjwawk
 01JzEfvWIL1dB9bVLxiDeZF5pRDhG6Kig/l1vq3kNjk5RAe1RTvRGoek/HJ+yoL57MTe
 DDCWr0aKkMA8SL+ZSU28YHyLr5XPO0u7PoPOubC2Hd2TnXL2hYgEe+hkqXPmw3BKv4vM
 5wUWzbG9XUFFqOZ0cv0CVdPyjp1CaQyGSKD4xNxNO38MydhGwCM3fhua0hIRwNmtsTm9 QQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3f6gpdcwx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 08:29:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQOscHaBuORvpT1aiSFH/d4mc7bZuxceyeP2lx3/x7lYNT4mR7gsljTG1UFz/V3FwAzCZX16XhfuhfA230DemCnbqFbPxKEEH1wbP5LEAz2ClPUPwliyupWCKjwcY+G9zlwBHT5hCcwoK18sLeZY2pZ5kX4kgwEMd9KNjCFfYqy4OuHMCrKfwsB2EqVzwnlHXgGSttOEF5gKBhfxFWZiMDLwexrQVejkVaMGexJSHYhRgP66Epf8xNkTCJCNrzyCqlSNaGAEPrEgQo4UvXH3yw3YvwyFR2ytOu3GfDRGWzIbBXY6zrFi664bEPhj9qfMVp5Qg7ozXFP+Ik18+QCq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkCrIOak8zDCz2p2CL07p7jkf0bjcqO+SO7njU8RzKE=;
 b=TefCs2BThuLn2xMpBQswCJtzTsXUKnBTy42VrFXsxQIwR1PvbE38BBA910bxitFc4BME+4V1lx6OZT4KbmuD3iMcE8uchC2DEapwQS+QVM7lC4w7GnrcrT9EDD80hvsGbmWQ9o2QQOcBVPB5ZP422wHo4EE6lGligpzRteFa4bSQxvFX7c5NQGXjStSPAe0Ct/IwEbUgE15KEBaTx0kVoRJ3jhFd9b+b7Iw4+CeLknkgWL0I0YCEwhqV8uRUyOTAlLdr5OC6F9BnVI93z4FETHuZ1TPqL13yySD+I+aN3NPs1+B6Pr7Mn89wAWD/Y90h4v9atsLi8NrF7//n49Lbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkCrIOak8zDCz2p2CL07p7jkf0bjcqO+SO7njU8RzKE=;
 b=Eglnpj/alBzQETyuYlnSrcm3WkiCsINnMkuTcUJ9ZsS6rnGPYU638BKmQ/2pIZQwqw3bmI+JFdtOOrZ84Uw89qxIzZhojuyvmM+oAUj57cjMmrSDbANBCGctCFlmyInf9+ZjxlVOYSsrgyCNvmGvY+KCxvG/TfE98aKJ/Qb3lcSawnppoYC673nE+yoi9UbkUJMIHBq/luTJE9Tga7Oy+byFFwS/3DCacAHtjbZ9pf21KpOzkG53sJbqxe/kZ6zUQ2WkZxfQsYCZdtpL4XQtkT8UqTE+YInWOD19FHPGxORNz6cGabn6oppwUs4dN1HYrLnBd7DfIzYE9GCVwpXYgw==
Received: from DS7PR07CA0002.namprd07.prod.outlook.com (2603:10b6:5:3af::8) by
 CO6PR04MB7492.namprd04.prod.outlook.com (2603:10b6:303:a3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Tue, 5 Apr 2022 13:29:55 +0000
Received: from DM6NAM10FT008.eop-nam10.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::ce) by DS7PR07CA0002.outlook.office365.com
 (2603:10b6:5:3af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 13:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 DM6NAM10FT008.mail.protection.outlook.com (10.13.153.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 13:29:54 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge3.garmin.com (10.60.4.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 5 Apr 2022 08:29:52 -0500
Received: from [10.30.196.25] (10.5.209.17) by OLAWPA-EXMB12.ad.garmin.com
 (10.5.144.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 08:29:53 -0500
Message-ID: <8b3ee5be-ca55-bbfe-cf15-64d68be87d72@garmin.com>
Date:   Tue, 5 Apr 2022 08:29:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <Yg9EmVAHpEpmnLok@google.com>
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
In-Reply-To: <Yg9EmVAHpEpmnLok@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: OLAWPA-EXMB1.ad.garmin.com (10.5.144.23) To
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 326d039a-5673-47e5-cf20-08da17085ef1
X-MS-TrafficTypeDiagnostic: CO6PR04MB7492:EE_
X-Microsoft-Antispam-PRVS: <CO6PR04MB7492D552EBF51A7D2E35C99BF2E49@CO6PR04MB7492.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVYYhwbBuknZtcWnLgWeYrEW83I+xlbhei95m/WBLJ2djOvNZelYvLNda2dnC4N7y5J1ocNrVr6gNrlkM3RGGLeCbYxfJhbqyjeXXEfehavYDlwD25GVjBP0QZotC+euZcHINKVBI75BLiZGZbFgeX3dTEk1crfaLFStOzrbnIKcPJPp9DjH4GgWWEyqmf9hPPX7Xbe6zrkaT4rfbY7dpNKJpmktEqd5LDSZnqvuT4biJlRMw4mlL9xl1MbxvYzSfgQ06j06aP7q2VGateAf+jKD5TdLjij779sSNrAehX7ruLaO6vEXYrcfeifyzd2VFmqZxgk8AqasJ6nV2xDZ7Im3M2TTQy19CEfsDpYg+JalvPi2i42ioC0IJ1VSZTtAWnowAeD6lyjZ7JYohR0AfnWb/CfuyBmom+RsTQCo77Iu264lVX/OXs6PNwrzjMkRqSsflNFOBPPEtCNPe1Lz+iBrUL9YVOUSYCe5A4RComB5Nd575g0I8gWmRr5VJuxVSvcKT2zej6jYLyUjBfwduxSIollidmFJsg5jyeqwCTsfLI9MS7Bo17Qds/R7QSOqLSx5iQO08YJ4tqQqz/fldqUGjmmZdqlE7Y1bVDr1YxF/Fk53q205AeEDwqv0MjsYcWqnJEZfcGR9ER/oomXhGBOOO/J0eyx6VhDpyLNxlyVlNpNmRdmxQWbEqR85TkHy2Gv1sNpJHDcUuJO+QER6wSjF9dHuCrxs+cmW2UCfGalF4H998T8xf7HFnr3CcjnTWi0GerAdZXZNp8Jc60pqUQ==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230001)(40470700004)(36840700001)(46966006)(31686004)(186003)(426003)(5660300002)(336012)(47076005)(356005)(4744005)(4326008)(2906002)(26005)(2616005)(8936002)(8676002)(7636003)(36756003)(31696002)(83380400001)(82310400005)(6666004)(36860700001)(508600001)(86362001)(34020700004)(70586007)(34070700002)(70206006)(40460700003)(316002)(54906003)(6916009)(16576012)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 13:29:54.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326d039a-5673-47e5-cf20-08da17085ef1
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM10FT008.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7492
X-Proofpoint-ORIG-GUID: RF_CWcX_XZrzaQaT8WJdUW7E0i0s67Tc
X-Proofpoint-GUID: RF_CWcX_XZrzaQaT8WJdUW7E0i0s67Tc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_02,2022-04-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=780 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050079
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Please let me know if you have any further suggestions on this patch.

Thank you.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
