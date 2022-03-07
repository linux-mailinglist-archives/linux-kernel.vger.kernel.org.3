Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115944CF3D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiCGImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiCGImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:42:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709663529
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:41:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i8so21941862wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jgpf11r6JREUakzcMH7I1ug/w8r11Lg1Dun9m6fhLxk=;
        b=K8x6OwcGNWTlorJJiD/N18xtHzZK/Ig7ebH2isVXcBYEW6Vh/nngKYaeeD+TbJWPpU
         yCHC/2+8iN0gG1SwUBAWRiP3bqGmG4F5FH4aQAP4L4+wWWpYYCZFSIYREts+X9ATHrP0
         iENdErazQZAzjUTWp5OagwltQZ+9+ViJVYqyG+LZi/KjwjO42o2/E8c7l6js+M/3oRxm
         T4EqD0cn4mCDLMzW0PMlgJ25cKEmaEgGLvMHIFc8L1TXRs6Bx9NeTdV9Uy/W6jAUmIGE
         mVCD5oezfk6e1LqyMOg45vNfs0J+9ZeY05vp1pzOM6OJntRoNPRBGt/n763nJS/Mwo+c
         wR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgpf11r6JREUakzcMH7I1ug/w8r11Lg1Dun9m6fhLxk=;
        b=AE9b8kT+TDJyK+bdnRXshzr/BYS1HzO+h7zSaOg3xV4a/n2aYw4wLf6Lx29CNbxIhT
         rc7MV8p24oHbBFhdNMHlj/bv08cuz2CI+CpYETP/nxqiuuAHNfM28Uk/VQJgmzANlaYV
         su8aP92B/U6WilNevyCkN1nCDEOqGoUV01C4/QbfjTkhMaofK3Iv7kEV5FYyKsPBNkxE
         y5ppfF/EED12u6jhdv5qf7aIb/9Bd2EzXkk+dx2xc7LHgELE5fLyByyq2wQaSKMpjn9l
         h3e0vgvJtKN3feQxS+mGsCSh8o3ohk8KB6Yp7lB1NQVzN1IMFu2NBc6PxLk86Jmx+5Im
         vq5g==
X-Gm-Message-State: AOAM532aIx1WCMZoahlA0NVUwwBJbycCyGdanPGM/uPklBJnoDchrCEu
        K5G9yDrBQdeBGAZqIOef2A8GFQ==
X-Google-Smtp-Source: ABdhPJwXlGvZQmeKxxCzapULuFc47U/oA64bW7VjZL07iz9SNIdOFm0DOjZntjE6xGt6PUKhLZoYFQ==
X-Received: by 2002:a05:6000:1569:b0:1f0:47eb:eafa with SMTP id 9-20020a056000156900b001f047ebeafamr7381021wrz.194.1646642487195;
        Mon, 07 Mar 2022 00:41:27 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:1451:71b4:fefe:6096])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d6d8c000000b001efd2c071dbsm11199969wrs.20.2022.03.07.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:41:26 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Shunzhou.Jiang" <shunzhou.jiang@amlogic.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        jbrunet@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH V6 0/2] Power: meson-s4: add s4 power domain driver
Date:   Mon,  7 Mar 2022 09:41:27 +0100
Message-Id: <164664248244.1285549.14653525234263258346.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307025357.1368673-1-shunzhou.jiang@amlogic.com>
References: <20220307025357.1368673-1-shunzhou.jiang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 7 Mar 2022 10:53:55 +0800, Shunzhou.Jiang wrote:
> From: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
> 
> This patchset adds Power controller driver support for Meson-S4 SoC
> Likes Meson-A1, the power domains register only can access in secure world
> 
> Shunzhou Jiang (2):
>   dt-bindings: power: add Amlogic s4 power domains bindings
>   soc: s4: Add support for power domains controller
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.18/drivers)

[1/2] dt-bindings: power: add Amlogic s4 power domains bindings
      https://git.kernel.org/amlogic/c/40b358f6156ac516e33e5252a8769737054da24e
[2/2] soc: s4: Add support for power domains controller
      https://git.kernel.org/amlogic/c/f2b03c1056ef5c0829678f51273eace3e6327884

-- 
Neil
