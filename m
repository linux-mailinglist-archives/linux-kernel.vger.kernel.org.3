Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B54A7AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbiBBWTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:19:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52717 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347855AbiBBWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:19:51 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 503875C0195;
        Wed,  2 Feb 2022 17:19:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Feb 2022 17:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=HYHjvxhYOJOxeZDWBoOY62isJ6CLiK
        ik8MOItcCLd+A=; b=CCuXduwY/F3tByz8mvCbfua2NkX7u2zve2V3sbhzMv0TqC
        z1P6hrRRr0js7mwqJV++yoNJKtM1iaQGk9yxg0+ZrU2kN9f+33NlseoiTX9s5j7P
        NpNpwaREryeqGqQauPtKZduNFRqblCbt/dH+kTxyTxvjDC94Ay5sN7HG5eY94uBH
        +vlTamxInW3gQggezjv4GAejQaeOoPdDwJ+MYFVmucXc2F4DAULb/2NAEpOPRcQn
        hQ7PhbdpRfAufXYUEJb48CYWljZXw0YZahJ9TcEvpyqh0HAW4q+k7cgIXTnRx134
        fHj3FQ8pHLDLMuh/cJp8AH9m2AZNmICZ2f1A4+yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HYHjvx
        hYOJOxeZDWBoOY62isJ6CLiKik8MOItcCLd+A=; b=LiSODOiQ15PAj2dVo7U599
        vTUK0VJB0SRsvtoyQTKlmY+S/9O4gp1l3bJLv83BZpZc2xfJ4n7DOPeyVM11uH4+
        TF5GXpfWtFNMIIE9AFsTnhetMdIWcOuJ1wwzSbs5z9Eu3mYnpU5KqdA0UqlVL+1Q
        tdk3d3iMEKqwnVe8CMqGvImIkPs6qxJCeTNTnzU3OnmYu8kDflNfRDiga/kbNo1a
        vB4BUCv3sHx9CzSdsM0g/yCNstb2BfmKwXU+vWA41QGejWz4fI8lM3xifnj4EOFK
        8CdKG192LzCPSyXZrTm4JM93XSQPVx9zBXUYd+e6bI049cQGwiX1br2kwpD9lr3Q
        ==
X-ME-Sender: <xms:hwP7YR5DbmdqCN224cWJMkfsDyJgu4AzWZUIusXdqdnYkSRwD8bUTA>
    <xme:hwP7Ye6j3UUvqSnY-T7FD1HpmKQTEqpol_p1iQ6LMCTopxaUz9ZZ1quqRxoB6iutc
    u-mHLXOMeoq7r3n7Q>
X-ME-Received: <xmr:hwP7YYf4blt0lFHqTXddKartHNxsaP6oiTy8Yonb9lBU7u4bKEEKiifj2Y-O9okLOIcuavRdzofDukfnrFW4_fsfIWoFWl2nFdCII8zd3617k_Rj5j-xaq5WLylidYpkVfsGpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeehledugffhjeejvefghfevvddtiedtgeffledtteevheejgefgvdfg
    ffetudfhffenucffohhmrghinhepfihilhhlshgvmhhirdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:hwP7YaKH4BQomIrBq3wpG14OwBWgc0ru_ogLDZirdXlvbaWSagztaw>
    <xmx:hwP7YVIQEV8gOIbTJJXcaRwyhU0RU74s3HKS2s85ETiFDXHkK2KstA>
    <xmx:hwP7YTw7bHeWSiVuAo-A3_liVCLNRPe-ZCwuztIpQvivH0vrWJ6MhA>
    <xmx:hwP7Yd-rinSFaWwqEhmlA5O8up_PeCWdFrQyvJCG1qTviYR3wjR0LQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 17:19:50 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add willsemi
Date:   Wed,  2 Feb 2022 16:19:44 -0600
Message-Id: <20220202221948.5690-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220202221948.5690-1-samuel@sholland.org>
References: <20220202221948.5690-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Will Semiconductor Co. Ltd. (http://www.willsemi.com/)

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..a8ab97717a46 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1340,6 +1340,8 @@ patternProperties:
     description: Wi2Wi, Inc.
   "^wiligear,.*":
     description: Wiligear, Ltd.
+  "^willsemi,.*":
+    description: Will Semiconductor Ltd.
   "^winbond,.*":
     description: Winbond Electronics corp.
   "^wingtech,.*":
-- 
2.33.1

