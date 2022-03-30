Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280714EBB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbiC3G7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbiC3G7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:59:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2052.outbound.protection.outlook.com [40.92.47.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B04DE0AF;
        Tue, 29 Mar 2022 23:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frtHwKnQ6fYCFR9T2Bvd4nhxk+12+dGClzsUlX4vudWuauS3pxi5We8KbVyKJu8cn10H77wxmrU9UcM2+cOTe9qJEBdCRsteXvD4GLr+vzORYmktshqMPj4QrqxoQEpoBK53Fh/5+PUPcJpjVFKWTelKasi8XkN6GjRqROb6lVh12kb0YGNRNjPpWZ9sR7yjsrUXZvui0oJa3/DqyDCgMcSCOnEDEGyzL9mR8o7BLcuwoLV5T1hC3o4OMECAbE0UwSuq08xkabL43k6Y1qEt3BWTrRXua7mE9U+nKtURrJViav2wHwYbSTHLZesbuB/8tSGCruegZ/28jEhwPLiuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GbSQFeXz9j5Ceo1yd+F/1Ne6QzvuHas4kLXpgLdvfI=;
 b=fDewjC2Ny7XXWkg8osAMmIg7IkyCOA7OnC5k/oe1R2Saxrd887jr9/mgqp+Rkv5nGzh+2ChiqMYKZqqKK1+B0jTkGyhOzpGXnEcxUrIIqnRdupBVOgMgmO2ZyFWtZP7C9gKo6sVdCIFV8KT5Au0P+AjWRjiPEBCcwEr6K2O8Q8PtrxuNlvKhDFQr6ECArWa+SjpiMneTQ7HIuf4b1I1slFCkj8vXru8FA2FG1/1p8gHfbwFugDnmMbGXHmdSPws3CvGSi1p0gK6zPwF6875AP8+UuwDJ9DsxJJoy63a2sHqDRjHKjvcVMCZ3h2kRoJvdQXf9kY9VPP44I7eWS2nwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by CH0PR02MB7899.namprd02.prod.outlook.com (2603:10b6:610:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 06:57:43 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6%6]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 06:57:43 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 2/3] dt-bindings: display: novatek,nt36672a: add backlight property
Date:   Wed, 30 Mar 2022 12:26:38 +0530
Message-ID: <BY5PR02MB700931ACFDFE4063F7A87C38D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330065639.245531-1-jo@jsfamily.in>
References: <20220330065639.245531-1-jo@jsfamily.in>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [V1VkMFk6QHVnZ3f7mxi26pvQTK5stRYgys1CnZGYNgwYbBH5LbPGEx0tY5uFY8nh]
X-ClientProxiedBy: BM1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::25) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220330065639.245531-3-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ee026c-f5c4-4668-0c46-08da121a96bb
X-MS-TrafficTypeDiagnostic: CH0PR02MB7899:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HvI2nCE+DpD9QpvF52WvYx/9fOMEj/jyKHQFykIkItnNOsWKD68ALCEoz/yd9xtvkycJyOlGxiAOIXM60RghpF9C/lxHIHph1c/dhc4DaUjqLxbX/icqVFgCAq+V+G1ooTKLScEOLxj6hiO/38ibo929YykF3Curm1vjNNXofKbGiIizmxsNS8IFfnF3SzWRxrpLFUOm+2fOH+BuDYqIe1zjssemYOvQW6mfvz+oaUKXCEWkcL5/AhnN5WcnQ3fioDH9IMSNpRltcvxNVtFzoAQyLplytgORd24rrwZs4XJUcy6xgdrZRlobjlnyehEUU8+jpvgj0jun4+HKNxZd7nHYZ7BEcU4D/csDhrmnhvIZsT+1vNSrbnrDTBUMgaYZaR2HZHnaqIE4+v5gqnbGqwAzILZvjoS3PYU6+E3o94J3pV3fq0YjH1jR3GbdrFC60wDqDW3EJZj5uuapWwg0EzWyygskCvnICguXYiBZE00DsF6BecNX+f58v9OldAdTPg4sVMTQjZIDMlzK5GVS9uFcGLjZMHHLkJSbz95R8ObDRkjexItw+8Qu7V60t5VwdGqIVadaVMqqySq+shHGA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?asoMpaBEpqaTVkoCL+jqLv5ZVoSqIxfeXGxky0Av/O5psmN9PMNMFyhvg6yH?=
 =?us-ascii?Q?RXn0lmMZbmaUDLtKvSq9Ibn5Lfb4jm3U0Ea8cXDL3B6nHkFOtMB7UPgZFStN?=
 =?us-ascii?Q?OfmyMfgWRyBaVKauzYD8DMR1hcWdsXxotDuq11vN3M5NmDMtrSeimN4x9kww?=
 =?us-ascii?Q?jkaMvvQJwBDkIGgyEimxRUVUSLyfcsLqGAtanXO04dJndrbIXWGaPnhmEhZr?=
 =?us-ascii?Q?SL3ReycL9Nv89xd04cOp1slktPfjVaAvbb7sKgMqY0u88rp5OLmckG9TPMv0?=
 =?us-ascii?Q?RlLg/q+zQaq2gJ1sFLFuQ95/buIgC6XN9hTtFDLj8dJ4CEkhVHMYN0DFVxHZ?=
 =?us-ascii?Q?OnwNyiK2dG3yYz058rRTuerUuM23/3Uz6J6tdl7y676SjO/tj3Egs5ML29h9?=
 =?us-ascii?Q?aEQQ5kIF4h3QUEFF6WcuCmey4yvQAWR6UWE4GAR2fTGRjemi5TPwMEsb/ppg?=
 =?us-ascii?Q?VSnh3FGjeSGs+rOlZt81thrl6WFQDfxihRzzQNfgTZ1ig2XNemfkPCXosjH5?=
 =?us-ascii?Q?Igw0176NmjePSQL7AmsoGNeny9dqmuryEDXUBwEikUwhwb8Yipn0ReFwrkZm?=
 =?us-ascii?Q?guIhhxIw/9GjgPjXniRvqorsu/Sj6IBa8dkPxGaX0q7sxH5oWWROePFTNatN?=
 =?us-ascii?Q?MExCg5uAKcoxIFdr9E0Nqvs+FjhqudOPwRn1/3lVBEtOZp/UXTm5zNW/FxEK?=
 =?us-ascii?Q?qDG0kAnVuDfVZCdSKnNFRR09/Klc3QMyY9n8UJGUEQkMJvaU/ToUB/1tqhXJ?=
 =?us-ascii?Q?TvINxQCsykpuCNl/eb76Jlxax/Zu+3XInPSHSZnzXrPGVqEZedAhjneGQtTy?=
 =?us-ascii?Q?Khjxh10RNNfbbRBPFVQM40N4hZo46o9OsmV5/CaTB9vlldXlpiz1luzDQ1sL?=
 =?us-ascii?Q?4cuwXrawbJiInbqtIKDOddTj5J4AFoXADGUK2yu3djovKI0nJdeZcvrxFjpA?=
 =?us-ascii?Q?7ebFS+pko5HoWkzsQaoIYtYp9H2gss/hLwi4yDeNOWHcAIjRm7bq63xQHnCU?=
 =?us-ascii?Q?l4LHqvp9zJaxBWCfF5fiawHJ9CGJDEocmFRkdBji/CfHtJ6Zp+HYrotlPZKf?=
 =?us-ascii?Q?chGVxzgHi0RTHvKo6if7WORUfJZjPoKtXo0iJtwxW1X8UYuuqyOfWq8cZHOe?=
 =?us-ascii?Q?ehLNDqhTrHWYnO31fvMDGjf2vdZ5FBJUz7r8Vn0JmXSdxt+7hogEF5dJEwo0?=
 =?us-ascii?Q?1CGELIxllzXlb70nkQYalR8zIN8X9ZtWN6rUux/hwz/bMGe41BCAnQ9wRdaw?=
 =?us-ascii?Q?/aHOj0gHvGWcvTBeX+EsuL9qxxv9xXbAceI3t0ZsiKJYBsXRY9nYDxfpomuA?=
 =?us-ascii?Q?tDe1FRZ0eKWEbbGNuyqbSm86abcTcyaAV0MSJjWenpf3ezpPwZPekizg8PMe?=
 =?us-ascii?Q?7huHriGydfVgkXq9iRJ5Y6+B05d7x6YkoYLAxgvQO1P+KcgYPY9Ycom3S1Tg?=
 =?us-ascii?Q?7sM9+z3hlCg8w7lTbD89LDHX69HEkt9WNGhOW1QbMhFEbu1EpsM1xw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee026c-f5c4-4668-0c46-08da121a96bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:57:43.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7899
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add backlight property and update example to include it.

Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
---
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 563766d283f6..41ee3157a1cd 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -46,6 +46,7 @@ properties:
 
   reg: true
   port: true
+  backlight: true
 
 required:
   - compatible
@@ -73,6 +74,7 @@ examples:
             vddpos-supply = <&lab>;
             vddneg-supply = <&ibb>;
 
+            backlight = <&pmi8998_wled>;
             reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
 
             port {
-- 
2.35.1

