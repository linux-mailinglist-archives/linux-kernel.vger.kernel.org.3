Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9866D575DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiGOIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGOIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:45:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2032.outbound.protection.outlook.com [40.92.52.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C2814A8;
        Fri, 15 Jul 2022 01:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW0/zulrJqn9XuEH+Xnf1Cf0h/G91Crblf8pv8l8SP/Wi4VErD9ZH3nsPeer5DmD41X4dXmXmUH3rZKtUPm5yBACKUsXU7QNy/bamm98wespIuImzTK/HjDLlQOZWqjvNKDbkdfsPwZM/BljbXE1Yt/2HouWvQPx8NLP+YOeFi5qL/tFk7rwPCfRUwoX5iklOluHsYRK3NgQleZiHd2kkDyCwYBhV9vv/XGBuUtvXA869ZJ2U3bWqZcoIPGKnYYZP8YaWE/xB/hAmIO34eXuel7nx29Tf6jzkIJ5w/IM1Z/ExobltLVWbVOiompD5oqsVYB2PQZqmXa5Gz+s8PNyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZVxV/oRzw6lbv5GwOBud1RrA0BNMnDVql40rCxaK+U=;
 b=Yms+vMWUIG9Q5mv3XnayFf+3Ul908idT3o9daW4zBxhoIF+NGiuiaZaa+8kKCbRKxXTPScBJ5SQKTilAEkVSmfzIhOe/zWDIBPqdCiYCUGfESDsilheDX9eEfDJtGcD/6rMFBsmE0EVxO8+3z7u09Y6tDgPd0MGQg5NsegUoycvPTun/mXtOPrzPr1o5IT+kDLTOpZRhMcXAzf+lDGs38EHJrpzLiP/N6u0OpT+8WhedVhvRlaFt8JkMB5p1ZnvdqvCpDfaz9aboB2oCGwWfznhytkpeg5KLDzI+7xiVNgoe/1P54/34d66y5aZYms8a+mGvJmvljeEGH1BIE1fUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZVxV/oRzw6lbv5GwOBud1RrA0BNMnDVql40rCxaK+U=;
 b=rv5z5AnhVTzehMVx3fBFmMKK3QO9/OdgIj+7AjoYzbFJ4ze85/XI4BEo27aOZSVoyumT63WeZ2chCOAY8kNGrEera6afe7iIuTYms9Ar2Ps0m/jJYBW6AjxY52V0Zaq5XyolPI/wTpJxyyYEEjqAj2ajEyimIwEwa93CcoHrO5xZIuM2bulJGHZBdaM1Hv1MsAhMv1Bqnr+3+PJMiPyLzsBkaHbOg3b3k8nRnp+FuDx11EfqTrBJ4s37lALFdLsaoXTg7tsaT8HKGSBqZx6YtU5tM4kngF+dHCBeLMmke1aon32cP6w9wdm9Y9VjkYooS50eleUAv7SlzJ5sUtp77w==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TY2PR03MB3421.apcprd03.prod.outlook.com (2603:1096:404:31::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.10; Fri, 15 Jul 2022 08:45:00 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.007; Fri, 15 Jul 2022
 08:45:00 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: arm: qcom: document sc7280 and villager board
Date:   Fri, 15 Jul 2022 16:44:40 +0800
Message-ID: <SG2PR03MB5006667607216338081A723FCC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715084442.115021-1-jinghung.chen3@hotmail.com>
References: <20220715084442.115021-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [246l7eAtu0c2TGLIRe3C+vEd5Us5iKRA]
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220715164428.v5.1.I338c337971904724a52c65641f601d3bcab7a990@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a32cbcf-474e-4578-2b70-08da663e4d54
X-MS-TrafficTypeDiagnostic: TY2PR03MB3421:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3tN6Lx21d8arNrG4bLgSk73V93NSvrKLs1+9zlpd4iwOp83gtbmvVDruogs0cu+e7fR27zdc6+sLx2ewzGYxcwxOv8is3ViCnfv2wBJMjWvOy+3CXdmZZNBl25C34OZXJvg6zS3e7zxsXdJg3RQHl2+AVpJjxZsF7eVjh0tzSJrTL6B5eOkfN01UNIbLcgRY7no/sTsMysl1oFlreJp0tvRj0wHeYshua03EZyNvhJtmhO/WXgCvhlVqVlgEWYWDt5hzehKqUPYBc31bx5il5cGUw+DgrkX7V+f6kLgTVb3kwWtP5ZsyjD5UJpAItIhg2oA3SnMrBgEkt9VWhXtO5pQ5kW2h3lijvxOZoVvngkKtY+q4QyDJqd4uR+V9X1lt7jikkCGG/hpKvUPhwbElrUG0mTeS2QGcHYib5d3fhNV0Q+Vfyy4HYc5bzXhBapqihDFYiS2gsak/dp55Dkl0Km9bQ1Dr3g9OUhrTkaVlGpnSWNcrvHIFSKrcaKLY47GAlj1hmlu/5DJenIm6DhuKvH5x0bA+Mcznt5PR9VmLdhqqY1F9lisipAojqrrOfH7s42CxK9ClbTQxKN9mltrAfHi0Aqb40bvYG1CvVFpzj4vkamLtzjraRiwnEr7p+OTCtl0nkeXKTrpm4HJotzqoie7YB3lSJ64aeJR7DYHh8wcqFbI0BBKYvbcQP1qruw6M1bj7zYrk6DKQ7XXgpLyZQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1EJYFAioLSgYp6rKbuB0PGaUUm53BeNT17LNqDMEdybvJczUZErYewKigl1D?=
 =?us-ascii?Q?Ukzl9+IUKWsKvPHcL1PDdCvP2mkVKy7AvWWIdq3xO1RAPHgFLqKGJBIwei6S?=
 =?us-ascii?Q?cRLiH7dZdYNZlTsh+dBTVtqW7pO+TVFRiCN5NGECG2X/nK7YjIY1ml8CFISY?=
 =?us-ascii?Q?2pI58BBHAdtFNEbsKbB/oZFaLATg51yVvqYa4dD3OEk4Z/QCLbMphCGGSyUf?=
 =?us-ascii?Q?c+0r51yZKM+x3C5xekxde65Umjc4QVNhdwHC5IRakAGfD1gj9rwW8DLfsbl6?=
 =?us-ascii?Q?FVHpu8ZQ9dFxqdD9eX1GykIWXSoOb4Yk/gx2VX2+I5UYVy7mIvPAjpiN+MkI?=
 =?us-ascii?Q?QTt4X3L7QUuyBlYxulVmFK0xMl4LhIX5gxp4mneQWtSETp03W1Hj9CEO29ss?=
 =?us-ascii?Q?rOo6s8S3HsXbUgWsiLbxmpFrcI0nzrOO+QPdeXfQ7Aw0It2ivuCGrQsOeapQ?=
 =?us-ascii?Q?vak/QxkGQjxsLjSVc1dXs4OctMkZu1zK33pQByHW9l9r7N0ZZlp/t8X2XfCY?=
 =?us-ascii?Q?bUOkdnYucvgVTeUKr/d/qJ55FiZTHGpk3N+vkCu1Ozzzkw5JK8JItobKZXSi?=
 =?us-ascii?Q?XpKt2GnpFDArG6Cspdd4/5eWb4h/L4CgWAHXrCPFirnycUcVmYq6NIHnOvZj?=
 =?us-ascii?Q?dG+KkRymZdvhv/WrIjZ+kiTAmLY0mehFs1CGVdDW/yE+VEtRV7GJcmEo4ZiW?=
 =?us-ascii?Q?6bJKnSC1gQHdosH0UiPiuvACFtKi0I8s9US5CcteN5RimHsTcXg+zLVWLUi1?=
 =?us-ascii?Q?aNDKOmbErUtWng+LY6PLsgawygKHGc5+QYXQByZIOsbx3BSTGUChrsRPBYUL?=
 =?us-ascii?Q?7r6WCi82C0oeCVMKYtfGcemhY9PguUAXOcz8a/eN4m4l4Y3WlAJ3h7/H2B3e?=
 =?us-ascii?Q?wDYJKGizkOkJXK4i2uiJG01yyTBFm1JIbljxUvpbZZn+W9mK4RUdrP8BM55I?=
 =?us-ascii?Q?nqLz750HrztlG+ZFCkdqQMJAqJ1L8zFb0LDgyiLQ5cXYTfH1htojWAYjPAfO?=
 =?us-ascii?Q?rdZEsOV5PAb7U1iWmZNtyxYj3dQhC82r517mQ7GIMOUUDtgyOUiz8Bd3VVxE?=
 =?us-ascii?Q?bSZdATk9q93mTQtYlcNd10ql/qpwsW9YNnU9omUc5sV6w7tfqc65wtppuET8?=
 =?us-ascii?Q?2u2oQZbY3UxQv90jxBmFkGYqrEjSJC4OLy4QiLJHBhYXrYmrE9jVGyVxbQg8?=
 =?us-ascii?Q?MfViAeQKPdRYvURlBiY2g+PhaF14cBjHYuQmZZdlz+R+Qvz2whYgL1X87Ah6?=
 =?us-ascii?Q?ia5E1gyUSIHb/KgxceCPJ4NU4BpUWXk7/pInMc50LhQGx37zcLBowdCB7jW2?=
 =?us-ascii?Q?48g=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a32cbcf-474e-4578-2b70-08da663e4d54
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:45:00.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3421
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LTE skus for Chromebook Villager to the yaml.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

(no changes since v2)

Changes in v2:
-Add this patch

 Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 4dd18fbf20b68..a136b1389c2ac 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -529,11 +529,26 @@ properties:
           - const: google,herobrine
           - const: qcom,sc7280
 
+      - description: Google Villager (rev0)
+        items:
+          - const: google,villager-rev0
+          - const: qcom,sc7280
+
       - description: Google Villager (newest rev)
         items:
           - const: google,villager
           - const: qcom,sc7280
 
+      - description: Google Villager with LTE (rev0)
+        items:
+          - const: google,villager-rev0-sku0
+          - const: qcom,sc7280
+
+      - description: Google Villager with LTE (newest rev)
+        items:
+          - const: google,villager-sku0
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.25.1

