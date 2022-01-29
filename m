Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3774A3257
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 23:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353279AbiA2WYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 17:24:33 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44657 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243417AbiA2WYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 17:24:30 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BB0BA3200E82;
        Sat, 29 Jan 2022 17:24:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 29 Jan 2022 17:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=ydwYLH4OnRKu74yuu5uIPeLM11ULky
        w8Fuy9MYYUB5k=; b=Tq74S3MxpD3tJbubtdAlDeCzvsxCRlKeDTDlEAwrw1izcq
        fVzUA8E+H0n1CM5x1UeYD75vncpKVzkUns8rBhCASPSzwTI/1+c7LVCQbeHjnGXi
        kWKiU43Pi1sj+0uv0BdBijYY85HcLAoBFuzHCoEC0sokP96VdxdDbprwiv/2gXid
        avCgZEvzMtcjUDA2zCFfgqR8m2Hk6spqhtJpawq80EoLhfuZAT2Wn9Stn0LRJZ92
        Gk9OqiNeI7o02+/SEW45GC0zhZMMSBWLHWSfUXlUzp0wvWoGK3cj40VAYftO/ZP9
        gH0pxahYyKPrRSf2MCqvuOizO68j2xLy41feHozg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ydwYLH
        4OnRKu74yuu5uIPeLM11ULkyw8Fuy9MYYUB5k=; b=CK7iPGYwuaHxExlIbqRu4Y
        Qy9m9ugvjA2YmY9vru/3W9SfgsuCv63MeqEexODcvShn19Lc2pd8KxHxMJ8t0Hzx
        c1qbghwYYNDdbc6UTqNsiXNt4D8g5eJhV4VgSe1b6UMJ48hRAiw598CueJQULc9M
        fnwv5bGdk5nhik5NFGCyhDhn2BVDOt/E9hzRCC2NgO4goc4+h/Cu2D5BoUSLy8Pm
        kH2FwtWZmP+BTMA/NDGGHBGq1yqHh1rDPW30DvFsqzLK0UuLbFbMnR13QJsgtNgm
        1QYvK58oZ2Hkp+ykxbqmgb79N6g6msUB0f8u6vXa/xUK8r+0Bo1tTiOvMLSElhHw
        ==
X-ME-Sender: <xms:nb71Ya5Arx69lUa5POPL48aErDWAYNS20lNqqS1DW2gp4LKloKTCuA>
    <xme:nb71YT76GFEa3zNq19juhVvKHVW0QBsxmqK0kEzldMzqs0Wqy31htOm4CQQgZn_l4
    at15uo9h1MNZBottw>
X-ME-Received: <xmr:nb71YZeY_mSDMDYo-RTa9ROOei-kR_XYHemiaHvSMH1dO5zMKXCvOdeLim3LB6aDql2YXiucmokMstYf7tZspVgPJ26CRv05_ZhdP4fMblKstWoKOH0dQ547CYC_zGzl368ChQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeejgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nb71YXIOlp872TofzeI7YyUFnXlcWRuw5JHffNFtAYbrAt6tUJIqAw>
    <xmx:nb71YeJWOi144qoDwPvST6S-hBGotScKQyrq5mT0dv56_bT10MmoTA>
    <xmx:nb71YYymJEE6QBnPUrkXlXdoRaK8dsCuvDEnaPjuPh5ceyWa7oblZA>
    <xmx:nb71YQjV_ImQWBxqTc8usbnjhHpoyjGT24EeXxX4Wwhig5sBEoSsAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 17:24:28 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/3] dt-bindings: trivial-devices: Add Injoinic power bank ICs
Date:   Sat, 29 Jan 2022 16:24:23 -0600
Message-Id: <20220129222424.45707-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220129222424.45707-1-samuel@sholland.org>
References: <20220129222424.45707-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Injoinic power bank ICs feature an I2C interface which allows
monitoring and controlling the battery charger and boost converter.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..a045d627a297 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -141,6 +141,14 @@ properties:
           - infineon,xdpe12254
             # Infineon Multi-phase Digital VR Controller xdpe12284
           - infineon,xdpe12284
+            # Injoinic IP5108 2.0A Power Bank IC with I2C
+          - injoinic,ip5108
+            # Injoinic IP5109 2.1A Power Bank IC with I2C
+          - injoinic,ip5109
+            # Injoinic IP5207 1.2A Power Bank IC with I2C
+          - injoinic,ip5207
+            # Injoinic IP5209 2.4A Power Bank IC with I2C
+          - injoinic,ip5209
             # Inspur Power System power supply unit version 1
           - inspur,ipsps1
             # Intersil ISL29028 Ambient Light and Proximity Sensor
-- 
2.33.1

