Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC914A3399
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353919AbiA3Doz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 22:44:55 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47621 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353913AbiA3Dox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 22:44:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 86625320100E;
        Sat, 29 Jan 2022 22:44:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 29 Jan 2022 22:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=vdWWCNOtJvWc4sMrKaZZ7I/SeIW2B8
        e2LLS4nBVAU2M=; b=kaE7rsUVy8lFlRiBHM2GAdsWjWbwMdRcKligo/vfB27bGP
        PQCeaZq8ibZXOnspM6W+gfl4ENiSnQOYEo6kJukLVZDyfN457b/BNZ+CTpuzTvat
        /SKWR24QJySEojggo1/ReKBKFOQfgI9z57Qr2jkvUFkpOGd6VuBp/4nyFch7OF19
        ksh/xOhssFGf/72MuE92pKor7CldwrffKMn7HlqwTXTwx2ckq6K3BxsgFbg9TGfG
        aAGjayYo/bghHpq4vlKd9z2r4zAfzMZi9Q3DB4grdlz71daOkowEgksNEGngczlC
        P038solEzsrn3z12TFNLlHya3VbGi/yx9ZY92GvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vdWWCN
        OtJvWc4sMrKaZZ7I/SeIW2B8e2LLS4nBVAU2M=; b=EFLXC3mp/1KoJgdgaqkArI
        z0EylMzESu+zRCeTZFBcOC1o1SGAnmETpfzo+wSKIfRqBaUbymBQ+E56zDtEsVJk
        kh+3pHF88fPDliu0+T4e1IWuv/ykxGvUtVYFsXGloDXs/RgBlMmuSFR2k13KVnHR
        c24gKkxubJDuPP5gl016wgG1yV0QUQEuI0Rc7kq0hLQwh9cJzyUiCKD8E2oYczIn
        FB4T+pOq23aahndi13fxagccE1VS/kQ3/yORce5eKrLK9okbLIoIiWwJZsliAhQj
        RLytUeuBHX6MwUTx4U8BG8QVVXptNi2juSBCyxhrJk4Xa7p8AQblXummPQyjvCJQ
        ==
X-ME-Sender: <xms:swn2YahMv26y7stvc4l0o58gpLQ64Vl9XN-dBhVQrsfk87LITvfGHg>
    <xme:swn2YbCvKKl8ezCy7Muhe__Omo4cjqAiZGp41dG39eeMf2QhKBdigccFVd5bIDVTU
    EJKP-Z88pKB-BNrUg>
X-ME-Received: <xmr:swn2YSFGyyGHg30fsOifCcTNK3Nyygcc0vp_f4tgus3G_j6S6UXlReZUDdaXh-tOYt77cMF0Lovx7ad-xQA8o9AlrVl9BQImXsxaitNnLYSIYfuoBmi2840SrSX0Ru60c610Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:tAn2YTTu3Y3HHsIN7bTsUH9uRH_eDsanlq2jmtwp_f6rFxADmB_dvg>
    <xmx:tAn2YXzotLeEDhdtvTg9yn8wfXoLBK0Us5Agqbz0-Hwb1WuOZW-kUw>
    <xmx:tAn2YR4BHRzm0X-PaF1pxGYVHDIaDOtPCF-rHS-dEz9z1mENnns2eQ>
    <xmx:tAn2YeyF3dI-Knbdb--tOWAKhFJq4Ua7XnZak6NNjff36jbTqJFZEA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 22:44:51 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/3] dt-bindings: iio: st: Add Silan SC7A20 accelerometer
Date:   Sat, 29 Jan 2022 21:44:40 -0600
Message-Id: <20220130034441.15474-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220130034441.15474-1-samuel@sholland.org>
References: <20220130034441.15474-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip appears to be a clone of the LIS2DH, as the register bit
definitions match exactly.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 71de5631ebae..70f755041d8a 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -24,6 +24,7 @@ properties:
     oneOf:
       - description: STMicroelectronics Accelerometers
         enum:
+          - silan,sc7a20
           - st,h3lis331dl-accel
           - st,lis2de12
           - st,lis2dw12
-- 
2.33.1

