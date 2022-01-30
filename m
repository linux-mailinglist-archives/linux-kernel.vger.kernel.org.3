Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD44A3393
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 04:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353903AbiA3Dor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 22:44:47 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40543 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353892AbiA3Doq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 22:44:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3BF1D3200E60;
        Sat, 29 Jan 2022 22:44:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 29 Jan 2022 22:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=MFNHX9hRQIea2PTY1s22SSHz0cyf2mfePzmnYWRwcFM=; b=osw4m
        fJ1PMZf8qXbMkAldwIpruu06qTq5uFV77pP+DFosbTPulJB7SXuJcXTWpyi5UjUt
        n4sHauOEbY3u/dRWcJ2iaXtf9hyyXMApUbZbOgg9gxpj739bXMXbEomkeSaxyS9L
        VpXpTSjOkUOnBA2w/7fHd66l7cB0aer+EJKDFEaP67jsqpJi0sF+uzXI7ENXe8l+
        p21yUpHL1iaBWqiI9d/NHgGyH3RitOsrTpAD+qXj7LwW1oOh58R0DiOZddCmii4k
        IJubI4zKWa97OdF6rmozcZeDZbekPYy/zICSP+O0yNZ9NXSCjXp1RBkBwCQb7pL6
        PlIrNaCVl9BpW0ToA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=MFNHX9hRQIea2PTY1s22SSHz0cyf2
        mfePzmnYWRwcFM=; b=JlZjZ2YOn3iNPLa8+s07M+4+GCNH13kuQBjqW1vxs3TWn
        rxF0ytAVIiVUZqSsqtHo+EgUbw2jjgIJVUOkT863XodYd/k56G1wWrsmVkMXWj4y
        sEa+MiU9x3ZwcBaW5fi8mdkOqbW3GNkxm1CkQ3yDfNgi93LVmt6yHIMwRVro+ROK
        sELFFmT06kBY6iASgvroCHaSa7U3dsVWEWQMM/6u7bHIsapYLreKIzrziUbFV/qP
        r7eARlKfcn4ElcdM2N6ZQ2FGweVFiB7oGvttjYZkmHA2FLjASMaYIjclET669+Y7
        j/TWCre2F8HbB3ECB7nbhouhNHpA8iUUbaWQvL5TQ==
X-ME-Sender: <xms:qwn2YbRgY-Ys870jjTqwBqZDdtTvGe12V6IcoVZaIgZ2jjVkxs52MA>
    <xme:qwn2YcwAGOf9kz6ZOkTI4qGcFsaplCOiqPYj9l1elDYlzd221RNSd-qTHyE1DF-qX
    UVvKR6otoXPTE_fXw>
X-ME-Received: <xmr:qwn2YQ33X5Gur483TIqrBDWEQd20xBgmXIgf1QKVD_IPGPzEs6tPYX-TPa2t-1cwcm7ev5nb3IweG97IseqhQRMqQ8cqooO1n7MK8-LwkOuU-tqWkNveRDduqQvu-YwMBAo_Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:qwn2YbBKsWgtxGn8U63n3Z0rt_YjkC4yt38x_FjufnqT-q8cPQF_2w>
    <xmx:qwn2YUixGpNA83fwne4xz4vzfFs4HBCB3-bOQebJbDJ4li-Mpa20hQ>
    <xmx:qwn2YfrH6vw-CQIACnhJfKIZxgFzsYkWhbNrX7NluRZpXKh80HkBaw>
    <xmx:qwn2YQhW86v5g_c1AsPKqA4N-A0NmXI1MATQlbZYeQqG2Evh59i2Bg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 22:44:42 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/3] iio: Silan SC7A20 accelerometer support
Date:   Sat, 29 Jan 2022 21:44:38 -0600
Message-Id: <20220130034441.15474-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip is a clone of an ST part, so it works without any issues when
added to the existing driver.


Samuel Holland (3):
  dt-bindings: vendor-prefixes: Add silan vendor prefix
  dt-bindings: iio: st: Add Silan SC7A20 accelerometer
  iio: accel: st_accel: Add support for Silan SC7A20

 .../bindings/iio/st,st-sensors.yaml           |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/iio/accel/st_accel.h                  |  2 +
 drivers/iio/accel/st_accel_core.c             | 79 +++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c              |  5 ++
 5 files changed, 89 insertions(+)

-- 
2.33.1

