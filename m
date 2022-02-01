Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFC4A5591
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiBADYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:24:45 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50193 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232452AbiBADYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:24:43 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C876C5C019D;
        Mon, 31 Jan 2022 22:24:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 31 Jan 2022 22:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=7FSuDaDzR81uLtJIhPlJACDFNI1bq2SOe6pRmMUgCx4=; b=A1oSO
        4brHQCEGnbs1HOXG6Di2bNi49Kgp1/TQxmjDz+wl1EbmCvUZjMvOkTWF1i0WjSIP
        TzihiQlTOqV1Oqx9PpBFs+Hl9UbfvkTgQiJMaACCSSYNj999GwBIJ3amPz5/tjpm
        MBP8/yV7uLjsykcd2uwur43xwY27uDclDhPTuvxcMdesw1IhFJBc08QY/ohDU9RL
        uMaSJ5SM14d5BJ7SJbH65ax89GE0hKJ5rKiyRdZRPcFVkawRHj/hozcpuQVCKZ3h
        TLcpp6A9RAWnhjJSxNJRDC3kRm8U7U+MGU+7v3gipNaJYJSXfSHjtfX/ISGxIGX2
        pFX31ZjXb4tbFIQRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=7FSuDaDzR81uLtJIhPlJACDFNI1bq
        2SOe6pRmMUgCx4=; b=hWYli7brubuBHXevr3n3LghwH1bRKAvRIS7SPfTbSQzDg
        5/ujTyukWDh6OJIQfQJyRtUTApVf1ojg64Co0heZybVZ95sQ3fiDjK5mEghTqngY
        r/v4qjHwOPBcZ/t/v/9J37YtrmYOjaY+ZNZ2O8MRaSwRZprL30JQMdOCctjQ87zN
        1sdEveVktXQJ4fIej19Eb2genuBCPhSw0wgAW/oiXuPmGPczyvrxQM3USEQQNieE
        P/R2lNuoSdVIa0zu3G/dbqT+f/Ui8M8zlHsdR35AioaNu1yEFd6S8pNoeu9KC2Hr
        NzVPFKMPHkykgf6OS37+D1O1F92ZB3iiDQ/++23mQ==
X-ME-Sender: <xms:-qf4YS35Dwo_kE35TgSi8v0RbSI1EuSkCDNyr-KQg7q1p4mrtpbWmA>
    <xme:-qf4YVGiHaY_vocZe7Y4pnqtLE9kGwHMvxowII8Xj2NJw6af8sH8U0NMZniy2T3Le
    3S6dH1yPnA3h4SlKQ>
X-ME-Received: <xmr:-qf4Ya46fzKwdTa1QDb_EMXSLNE6wDg8hmWau818D23CspLWihFjm_16NY8LNOUJ0zAus733Gq4AO4E1-JDv675vErmcJ2yIgCmVV7CptN-_-EFgzPuldSJAaQMaJtnqO-4CUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgedvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepuefguedukeegjeefvdeuvedvgeetleehjeeuledtheeigfelvedttdeiffdu
    veelnecuffhomhgrihhnpeifihhllhhsvghmihdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:-qf4YT28LxD3J5XL2GTp_YC9NwUzc73GLWisn5CwuXLTnmaRFE-Yyw>
    <xmx:-qf4YVG48XH3PMC92nHR61UtegeVIIq_6Jx5sN8te22OCfn75BJMlg>
    <xmx:-qf4Yc_cFlm1_fXYKVMjabwwwiXGZJY8NbaRa6rNprbOoFAmEpyP6g>
    <xmx:-qf4Ya4D0iEZbR9KE0vPnW6aqWbYvPSQ4UIJPbeRwb2xYuQ9EYlDnA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jan 2022 22:24:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add willsemi
Date:   Mon, 31 Jan 2022 21:24:37 -0600
Message-Id: <20220201032440.5196-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Will Semiconductor Co. Ltd. (http://www.willsemi.com/)

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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

