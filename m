Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588334BD2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 01:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiBUAEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 19:04:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBUAEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 19:04:33 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20122.outbound.protection.outlook.com [40.107.2.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28EA517DA;
        Sun, 20 Feb 2022 16:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzhJ49Z/CVes5m2Jhq41LJ+OLloKfEJ2DI0yQcLvZDrGPVVkfy/a5+qnjSSHvOdssVkxNdqluiPmzzVWRGG6J5iHviR0v1QGmmRPE4KBRtO1TT0FZIBKvAUXOgeuA/qtuLx2Px0O+HBAST8136hdsVPyqQM104e5NLZ1UVi9pvugfGLEts9jE+ZXqIzZUuPEZD4Ug3jqD++VSXULWg0TmOO+X1Q6Hoq4usteaFB8e5gCUw7YQ59xmaprS3zpL9SqnhQYNV06rrOisGEN/6x/QA81fJn4ItBs8YKyJVTepwdV04KD3ViKkff9q7wSCfmSM3nrNxZOr13xnrf13xxelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTLIiB/y6mc1vxLwhlpAfK0LDuk+luyjUpB+t8x8Odc=;
 b=RyuQjEhJzDH315IiEcJrae9SdLF7NM7ebSToQ+c1+xnrZ5pNB151oZXT9iDtucM2eaHbnX2Tw0YfIH+DW9Vt8S80dRG3ZrgMvET9jnGSOs48FKq841vqeC/GhCts9cQimqGl4jyRuShsPpuQ5m9nHPfd8gZVMAYgNu8xOGL1q69ZjKHMyvCqikzvUDaKL/w3gU8BA4frIc2uBQDIjSdEBIVXLJMAc7UxBhqnUxPHciAiKtNwrUfUeWMjcB2mr4W89j841evCeMUwURbXP+iBXFNMA40mHUP/IUxRRntcaSMbd19r/AcIPB6bRsyhSGJla0khTIb0t8KEsbjZ/GLZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ugent.be; dmarc=pass action=none header.from=ugent.be;
 dkim=pass header.d=ugent.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugent.be; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTLIiB/y6mc1vxLwhlpAfK0LDuk+luyjUpB+t8x8Odc=;
 b=eCe/qWOHq9UH9h/o0SHGVkiGRBwus4zJhDn2Fb7HAeB+u3O5cr9XEn9+nMnFnPqF3TRRvVmH/mD8o+QLHmqD2RS7AZNN8SNbPw3Q+VCB8i9wvTgoem805a7NXWGt+nzeI/5qWJrKxUhdoR0P9vzlawUlLmjqDU1b2i7wP+j98/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ugent.be;
Received: from AM6PR09MB2326.eurprd09.prod.outlook.com (2603:10a6:20b:46::12)
 by PR3PR09MB4395.eurprd09.prod.outlook.com (2603:10a6:102:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 00:04:07 +0000
Received: from AM6PR09MB2326.eurprd09.prod.outlook.com
 ([fe80::3538:ffcf:447d:9c2b]) by AM6PR09MB2326.eurprd09.prod.outlook.com
 ([fe80::3538:ffcf:447d:9c2b%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 00:04:06 +0000
Message-ID: <14d6e454-49c3-0a85-68f1-3f003ad032e6@ugent.be>
Date:   Mon, 21 Feb 2022 01:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Niels Dossche <niels.dossche@ugent.be>
Subject: [PATCH] scsi: aacraid: add missing manage_lock on
 management_fib_count
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0038.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::13) To AM6PR09MB2326.eurprd09.prod.outlook.com
 (2603:10a6:20b:46::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2e2d67-ce6c-4e53-f325-08d9f4cda5d7
X-MS-TrafficTypeDiagnostic: PR3PR09MB4395:EE_
X-Microsoft-Antispam-PRVS: <PR3PR09MB4395272CD3231D0F59BCDFD6883A9@PR3PR09MB4395.eurprd09.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn+898kyyMoExPCid999Q5LD98Fe0TkZiv756vIaMS4RBQSbVPPib1XYt1twGqeIk/VshHx5LLDPTEuuhvLNrggVPOo4MdDcRLWbVaPaTrKBQbCNNDKqFy1ao2eSLjiNtvxc9WrIrBtdhPMifc9InfA6eGRQzHjUpCcdgxjZKaLef81gsTBDiPYFsWqhOALCnkzZOZwJS0mxw+5sE5NDa9tMGo5LZqEGNa1a4/PIsHvY0DVo8nMnBCJvKnRvRjWvQQZYPHLmLN1N2I/Xa5ufYghFNMF/PA+Mhy1uBfwSw/JuG25JwXMdUpcc21fdEL2naeJCl+h5MnkxJFbW1a37j4tHYkUs2AKwxysJsdBfgT9J0zRHP+Yzemk3PZctuE621d4741e1xzHTFcWVsaEVtQfOByTwXPY099WrAAcskBU/4tVm/I4AQyPxmMwMS4giGAj7DoU9LwSiXwJAppY87XW2vSArNv826s3D5i+HnQVdjBJUYjkjCMNUpsxFBxJHtcnSHKFRTNmlx2i16VT1glXzNaK/L3grUhpQpfV1+Kmg4fcJn1eq2X5c/5nNDkDP+Dsb1utlGvIIPzREGjFuGug8q86cae2TQ4bEmXh+B3nGvD3uuP/6PAtNvjC0UGMBplJAMX04dh5l8mOJGrKdGZ5eQjqXFwFDo4AWbaJfuvFC53nMddqMB4X4IlnZ3HS3naNFh4fGIp5kNv0ipIRMgI3JHdzo9H+bv/JFfNKHJgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR09MB2326.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(786003)(5660300002)(2616005)(86362001)(6916009)(83380400001)(36756003)(31696002)(186003)(31686004)(6486002)(6506007)(6512007)(6666004)(8676002)(66946007)(66556008)(66476007)(2906002)(44832011)(4744005)(508600001)(4326008)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFM3ZFN2dFdlazJlakpianBzbU92azhBcW5qeDdkZUlPWS90dlFJbmw2cEg0?=
 =?utf-8?B?NUR6YWdSVnV1YlR1dVY4QTlrVnFtL2hjQkFmTmFFb2ZXc3VEQ0p5emorWk1v?=
 =?utf-8?B?cS9NWHd4R0xzNzlVVGxlaXNnbXE5RW41bUU2NlRKa1REd1lSWVA2VkU1S2ti?=
 =?utf-8?B?K0lnaXh1VFkydUVPb0xnYU42ZHhqeUljaEtManpBM0h3Z2ovTFBGQjNYTnV5?=
 =?utf-8?B?WWF5M0x0WW5WVlZFR1JYeFJyT2ZEcDBlVkc0aVFMYnY4RVc5QlQvVzFpZlRN?=
 =?utf-8?B?UE91d01HYjEwMytMSmdaZit0TS9iNEtuNGxwRG5ZckdFVHhacTdXcERhdHpZ?=
 =?utf-8?B?UHdtNkZzNWdJeTZ4dEtXZXVzbncyWkxobGZ4c1FoZEYxYXNrL0RsNlJja2J6?=
 =?utf-8?B?TUJ0VFJ0YURjV2N0ZmZobE9oQmE3eEkzNitZQVExa2JwWm5RWlpLYXJlcG5a?=
 =?utf-8?B?SGEwVVFDSm5lZXI1ZVA0eWh4dmxEZy85UTVBYkQ1eXlzSENRMWxWaWFDaW5F?=
 =?utf-8?B?bUJwK0JvcGdXSVcvT3pTRUNXcWJZSktqOFIyWGNjYkowUG9aQlpqNDJKRVN0?=
 =?utf-8?B?djRGdWk2M1ZqbXk4VERJZ3hWRE5WVElWZk41Syt6bG4vaXBpU0hHTk0zYzNT?=
 =?utf-8?B?Nm1WTE1FYkMvcWRLMmNobXFlejJ1VW81eEVWcHBuNCtlL2daUGJZTFNlTytV?=
 =?utf-8?B?THFyL29yQnZqb2ZLSkhCTnNQeE14b3VlWUZqa1dvd3FDTHY0bDFOamlDS2xT?=
 =?utf-8?B?ai9BUlpRYmVoWnBzcmZ5SVBOeXFuZ3ZUSUxxZXFnVDRzbFhMV1BTeXFDRTA1?=
 =?utf-8?B?Z0s1OEt2WXJLREhtTGxhbk9TRG5wZlpzK1hzTHFFTHFCalBuZUFENlhiR3h2?=
 =?utf-8?B?UWd2Y2dndWU4ZjhxbFVjclkxNE95REZQdjZzNUtqWXdFck1UY243dkRKQkR3?=
 =?utf-8?B?RTJpR2NTMVFkcTdNMDhCVkhBc3lwN1VVUVFsTTJyODZKM0h6Q1I1amRjOXB5?=
 =?utf-8?B?cTRWNU16dE1UM2FveDhKOFN4U2c1dGc4K2FlVzNVQmM0SVJINHU2NVN3WjVE?=
 =?utf-8?B?bm13VERVZktLK2FaUlFkRllOUExPYjRud3JDcnEvN3cwdGlBRDUycUg4bklO?=
 =?utf-8?B?TTRNQUhtUVRJYXdreXdiZHB4OG5zSEJvSUhrVm9PM2YzaHhLS2JxNFIzMjhh?=
 =?utf-8?B?UnBzbysxWG9nWkxIRTVhNThJVW1pR1VZNVNQOURZRCsvL1B2Y2FxZ05vTHFL?=
 =?utf-8?B?YzNyNW9Pb1BBUFFDNFp5YmdIaDhWa2t0QlAyTjdYSkFWai9oMWZ4ZFFSZkVw?=
 =?utf-8?B?amM4NW84TjBxY3RUc0tRdnU5aXRkS3JPSEJtcUowMDRTbHNYaU54TTBCMjVT?=
 =?utf-8?B?cVhxVTRiUU0vUjdSMWhMMDRqSGJtdVRnY3RnTXdHNS9kVFJPZzFmYXFLV0Nu?=
 =?utf-8?B?Q09weTRSd1ZZbEZHVGIwdjhiYTNpNW1UaHczUG13MHJrRExFQXpWSkRFVkVn?=
 =?utf-8?B?L0FwdUVoUGZuQWhnU241U3VkYlNxYjdpYkdmSndNeTBMdmY1OU5DM1VpRnVU?=
 =?utf-8?B?d0FWRlQ0MkR5UTYzS0lhdkRDVCtRN2J6eUNKSkFvZ201anU3d3FmYTg4R3VS?=
 =?utf-8?B?ZitwUXFrN2NsWmJ2MlVrRUNVNExmOTd3U3ZpVEpoWit3ODlJV2ZxT3N0TnhU?=
 =?utf-8?B?bUUrTnloUzQ5NzFjd09icUVHRzN0RktmZlZJMVJ2elFUZkhtTS9UV1NGUVVy?=
 =?utf-8?B?Mko4U2pxMmVXNUNZQW81eUlDL2pNRC9Ya1JCSjdKOG1hdDRvZ1NSdW1rU2hN?=
 =?utf-8?B?dVhFem9ITHBWZ09XYmx2WVk2TlA5UjNZbXFXd3B1YmE2ZStQSE11ZTBXUzNI?=
 =?utf-8?B?dm5VWmFJYXlsQUl2RUNHZFhtSXdadFZNdmMrS1pRRW5mTzlCWlBXWHJzOEtT?=
 =?utf-8?B?OGtYVnpmWitQNXpycDJHTlZQU2lFVVo3SVFzRWlEYWZXYmFMUCtZY3dtSTBM?=
 =?utf-8?B?MnJNYTZJbnZsVnVkVUxVcFVhTm9DM29yejZOWjdZWGpyLy9MZFBmRVdMaTVm?=
 =?utf-8?B?RkxCaXZnMUU3TE4rQ3FncmJ1R2dsSHdCZEhxREdqN1Y1Q0lPOG11aW9VZWZE?=
 =?utf-8?B?WTFwaE13clRVUTNKcUZnQTF6R3RRV2htNUhQNTFkRVZHai8xSWZPWkJNVkJL?=
 =?utf-8?B?S2RlV09xc1hTeFRMUFQzZVpXVXNZbDZHaG5WdWNSakFITWRnZFZuZU5TU0RD?=
 =?utf-8?Q?QeHne9QB8dodRPWlmbv2TaXGVGBmymAk2wBDwXadek=3D?=
X-OriginatorOrg: ugent.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2e2d67-ce6c-4e53-f325-08d9f4cda5d7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR09MB2326.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 00:04:06.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d7811cde-ecef-496c-8f91-a1786241b99c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JykuW15WwK7a10aGjm+otXNIfhIXpp7KDifOnrAGb7Gg6OhBsWH82/t9IDgm7ejFZIa8lL80GnskgmW/UozAkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other places modify the management_fib_count under the manage_lock.
Avoid a possible race condition by also applying that lock in
aac_src_intr_message.

Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
---
 drivers/scsi/aacraid/src.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 11ef58204e96..ca73439587ed 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -91,7 +91,9 @@ static irqreturn_t aac_src_intr_message(int irq, void *dev_id)
                                        dev->sync_fib);
                        spin_lock_irqsave(&dev->sync_fib->event_lock, sflags);
                        if (dev->sync_fib->flags & FIB_CONTEXT_FLAG_WAIT) {
+                               spin_lock(&dev->manage_lock);
                                dev->management_fib_count--;
+                               spin_unlock(&dev->manage_lock);
                                complete(&dev->sync_fib->event_wait);
                        }
                        spin_unlock_irqrestore(&dev->sync_fib->event_lock,
-- 
2.35.1
