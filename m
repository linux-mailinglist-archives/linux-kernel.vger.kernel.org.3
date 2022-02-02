Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EA44A7BED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348180AbiBBXvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:51:13 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58279 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348129AbiBBXuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:50:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 413405C0112;
        Wed,  2 Feb 2022 18:50:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 18:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=Qb1BuHwJZ6FFKPaD1otK7ZGteevZ9K
        auHoztuJpNNp0=; b=HLjqgB17ytoJKhuxLVZTe7b8JyaN0/ssnyxZ6y41lbqpL5
        3iL0HfuZfwxIxjnBH++t83h5oZGltEdCVMfQFyzvi0WD3L+OXSoF67cy4bMgtpOG
        6ke0q/BNSN+ZGmYEw/3awzBzx93pxukWPJJDAgdtKdcrHpyztFUeuKckchdfEd9x
        zXdhej4fuqPgXVMCvnKzDdp8d3/HBrt4AzZb+piZsqhCV0R+t0mO84S2R0LDRBpB
        bKCB8v6vpTMH5nnhh4VnqoERDMK/lVgACcXxNGVs8+go2q+ukBpJP4Rmnbpmoo30
        X/WpMh1iiK/qm4yvR80DltnKEZ74cNOiAXmvub6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Qb1BuH
        wJZ6FFKPaD1otK7ZGteevZ9KauHoztuJpNNp0=; b=alnMiUqX59yZUAOY4lN09t
        ruO6r71fOyakaaUD0AD2dqzjwONaF9X3WXFcRSimq3wWp1QnNInTGI+fOiJpMW3g
        Vc4fN+1xwjIxQirOjobcjb8SJrjjo6QN0cDO6yYmJwNMF26Uc7wGriLpuELNaodo
        psYVuXZnvwVK+mvDIdTXczIAPIIhdRKWNF0R2OvhD1juI74k2RFgx5FbJS+VTs/l
        XRlvxv3zPHS81VjRtGfiPW2CuNj895UtTKnSRgTiR8dzfG58nxFJq+2b7o0k6v/U
        Fayhz1RyhjyXYv+hqKARMKoKZ2KKh+OmPlO1qxaaAFWLybxGzdNPeZ3m8i1dNxkg
        ==
X-ME-Sender: <xms:3hj7YVTKaBJ5wOXSe1GIBX77Q41jlHBj3bWakoeboiBfSuZAl5IKUg>
    <xme:3hj7Yey5y6Hp_4Izg207MWg6_whQ8I8Wjf3jEOlxBcT6cn2dAGy4OCKp4hoQG4CIq
    UdnIvfa3RlAAzfr7Q>
X-ME-Received: <xmr:3hj7Ya2JuPEMWCM__jzB00iRFQvTr4boRw7u_69sXPYYyWAlRBrG_pjuJrb5IHf-hmNmhOQl8t3wl6iiRJpquT4N80hPywWIKksIJV079cZi2UZ43W70lmdBQycK7wAoz6I5Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:3hj7YdB4o-2qH_VUmHUMZpKHVPtYhHSjXtW2E_7iZj9SHi715g3m6Q>
    <xmx:3hj7YegUKQkcPlK9VJVlXz3RKrkCcIq7A3mnoRTEDHkJbz4WHAXodg>
    <xmx:3hj7YRrzDMbvphiVavSY1wscNFA_1LgtR5xcxggVupy_0QW6ueT7PQ>
    <xmx:3hj7YSiXh11bbSa4i7EBf-X08WZDuBBH36seP6CNjPH_4yJlwBMrwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 18:50:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: st: Add Silan SC7A20 accelerometer
Date:   Wed,  2 Feb 2022 17:50:47 -0600
Message-Id: <20220202235049.8051-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220202235049.8051-1-samuel@sholland.org>
References: <20220202235049.8051-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip is not an ST part, but it appears to be register-compatible
with the LIS2DH, so it can use the same binding.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Move the new compatible to its own section

 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 71de5631ebae..9735a2048255 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -46,6 +46,9 @@ properties:
           - st,lsm330d-accel
           - st,lsm330dl-accel
           - st,lsm330dlc-accel
+      - description: Silan Accelerometers
+        enum:
+          - silan,sc7a20
       - description: STMicroelectronics Gyroscopes
         enum:
           - st,l3g4200d-gyro
-- 
2.33.1

