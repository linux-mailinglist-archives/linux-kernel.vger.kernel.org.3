Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5504C5B1031
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIGXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIGXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:07:15 -0400
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED61C4805
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1094; q=dns/txt; s=iport;
  t=1662592033; x=1663801633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WIMedRdp/vCdubl76WnqCfmpNc51ZNpLrONKBIeSt70=;
  b=gbvtdRapPPlnzUbZdFtSd+6I/ljf+QZROg2wIkBxhZ6IGnHG5wqlOnMt
   ZnltYAHK/i43w1zBM6KU3lJexjZnOiaB0jpY8YIUeCDUNcUUnwvWDe3zh
   HHi0eVNAWuGDJDiC/Uq8IdGNyoLG+FDGO8wArnynktVTrgOvWqsBaCJti
   g=;
X-IPAS-Result: =?us-ascii?q?A0ATAACkIxljmJBdJa1aHQEBAQEJARIBBQUBgXsIAQsBg?=
 =?us-ascii?q?3k+RYxtiHGdCBSBEQNUCwEBAQ9CBAEBhQaEZwIlNAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQcEFAEBAQEBAQEBHRkFDhAnhXWGcAsBRoE+ARKCfYMhA?=
 =?us-ascii?q?6YXgXkygQGIHYFlFIEpAYpshVkcgUlEhAh1hAsfhlUEmBYDCQQHBUpCAwsfD?=
 =?us-ascii?q?hY2AxUDFAMFJAcDGQ8jDQ0EHQwDAwUlAwICGwcCAgMCBhUFAgIXHhg4CAQIB?=
 =?us-ascii?q?CskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkQCSEWB?=
 =?us-ascii?q?igNBQYTAyBHJgUHPg8oMjU5Kx0bCoEOKgkfFQMEBAMCBhMDAyACECwxFAQpE?=
 =?us-ascii?q?xItBytzCQIDImwDAwQoLAMJIR8HKCY8B1kSKAUDAxAiPQYDCQMCJFp9DjEUF?=
 =?us-ascii?q?wUDEBmZB3sTo3WCFZ5Ug1yBRohGlgIaMpZykgMBlwcgoj00hFCBYTqBWzMaC?=
 =?us-ascii?q?BsVgyJRGQ+OOY5XJDE7AgYLAQEDCYgKgkgBAQ?=
IronPort-Data: A9a23:n+88O6k1cOwF1MnQJ5P0FVLo5gxqJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIWX2HSPveMZGKjedB0a4yz9h8G7JfRm4diTlRtqS8xEVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgHmeIdA970Ug5w79h3dY16TSEK1rlV
 e3a8pW31GCNg1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJM53yZWKEpfNatI88thW6
 Ar05OrREmvxp3/BAz4++1rxWhVirrX6ZWBihpfKMkSvqkAqm8A87ko0HPhbbGUKog6IpNFg1
 s5E6bK8FBgVO6KZzYzxUzEAe81/FbdN9LmCKn+lvInDiUbHaHDrhf5pCSnaP6VBpb0xWj4Ip
 KdecWxRBvyAr7reLLaTRuBqh8knM8DDN4IEsXYmxjbcZRojacGYH/qQu4EJhl/cgOhlEPLUO
 eEAeQFfNiTvIDYeF1QIV64xybLAan7XKm0E9w39SbAMy2zSyhFhlbvgKtzYfvSUSshP2EWVv
 GTL+yL+GB5yHNCS1zuO/262i+Lngyz2QsQRGae++/osh0ecrkQJDxcWFlenifq0kEizX5RYM
 UN80iQ0qrc78kDtStjmQzW3pXeFulgXXN84O/Uz7h2AzqvPpQ+fGm8CTzlcQN8hstQrQT8tk
 FSOmrvU6SdHqraZTzeW8a2Z6GP0MikOJmhEbigBJecY3zX9iIN0izCSZ+1iK6+kkMb8RR/8n
 i+2qSdr0t3/kvU3/6m8+FnGhRelqZ7IUhM5623rsoSNs1gRiGmNOtHA1LTL0RpTBN3DHwXe5
 hDoj+Dbvb5RVcvS/MCYaL9VdIxF8cppJ9E1bbRHJZgq9z2392Wke+i8CxkheR85a67oldIVC
 XI/VCtL75NVeXCtd6IyM8S6Ct8hyu7rEtGNuhHogjhmP8kZmOyvpXEGiausM4bFyxBEfUYXY
 szzTCpUJSxGYZmLNRLvLwvn7Zclxzol2UTYTo3hwhKs3NK2PSDLE+pabQfVNb5os8toRTk5F
 f4CZ6NmLD0CAIXDjtX/reb/0HhTdyFgXMCqwyCpXrfffloO9J4d5w/5mON9JNMNc1V9nebT9
 Xb1QV5D1Ff6nhX6xfaiNBhehEfUdc8n9xoTZHV0VX7xgiRLSdj0ts83KcBoFYTLAcQ+l5aYu
 dFfJZXZahmOIxyakwkggW7V9dQ9LE/x21LWZEJIolEXJvZdeuAAwfe8FiOHycXEJnPfWRcWy
 1F46j7mfA==
IronPort-HdrOrdr: A9a23:n6M7jqj4w6xa9IYvsi/vQTRHLnBQXtUji2hC6mlwRA09TyVXra
 yTdZMgpH3JYVkqNk3I9errBEDiewK+yXcK2+gs1N6ZNWGMhILCFu5fBOXZrgEIMheOk9K1rZ
 0BT0C7Y+eAamSTSq3BkW2FL+o=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,298,1654560000"; 
   d="scan'208";a="934726692"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Sep 2022 23:07:11 +0000
Received: from localhost.localdomain ([10.25.130.54])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 287N79Cx032254;
        Wed, 7 Sep 2022 23:07:09 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     xe-linux-external@cisco.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver: of: overlay: demote message to warning
Date:   Wed,  7 Sep 2022 16:07:08 -0700
Message-Id: <20220907230709.271889-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.130.54, [10.25.130.54]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning message shows by default on the vast majority of overlays
applied. Despite the text identifying this as a warning it is marked
with the loglevel for error. At Cisco we filter the loglevels to only
show error messages. We end up seeing this message but it's not really
an error.

For this reason it makes sense to demote the message to the warning
loglevel.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index bd8ff4df723d..4ae276ed9a65 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	}
 
 	if (!of_node_check_flag(target->np, OF_OVERLAY))
-		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
+		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
 		       target->np, new_prop->name);
 
 	if (ret) {
-- 
2.25.1

