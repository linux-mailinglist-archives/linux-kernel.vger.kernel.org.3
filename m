Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA05592901
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiHOFKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbiHOFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:09:22 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DD16589;
        Sun, 14 Aug 2022 22:08:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 455E3320077A;
        Mon, 15 Aug 2022 01:08:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Aug 2022 01:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660540132; x=1660626532; bh=CS
        KC6w1bA8nM1A76JAooQJx5OjKisqiho6nwC7B/by4=; b=iuCNaHtsbsrq/ObZgW
        BeoL3AQ2tDNmAJeI1WuBSsOo0NLcsu9vLNQrY+ACR/huBsc7izbAT84HcwAgRCwx
        VeRtnajnc4qKP977d15TpsFJbRFfUzsJvS37fsv4AgZ1GPrAxRSClQHzVsYaEeW4
        XNTYGYRGm78N7DgcvD161+TxLTBU3svoWIC4yEik/e386K+Qc2T9lJrzASvkI5xK
        6R3MYariKi9nQGHzQYd89FwcD6+ZaqSYqv4wmdGdlObWD4HXVtbilXyGvBo6db1Q
        /xwrVIwWQaLk8z11dOwa9DxgkjVDrnPZfluXZHYxUic2kLEuabeL5nw1onn/gYSF
        XgLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660540132; x=1660626532; bh=CSKC6w1bA8nM1
        A76JAooQJx5OjKisqiho6nwC7B/by4=; b=VfAXbYTQDtOTY2GBYV6+TdI2xoBBR
        59DfgJhrpWv2gI7WVVVsRE8iIcKkH+aMxX/x888aLBcGunZDnJ2QRmo8vn1fFXrv
        bk4KvZbnqn3cGRIRvJ1Zb5iPJ8+y40NF7NlpggkyqDExKGNe2V+9z7L6JNMtWoB5
        lz7EHOtkCDAJON8ZUZhCxKFIVq52Rr2l/aRkfm+PdNuzrS6A10fT/7uN/twqE9sw
        ka4BMp9vWwRH5cvOp1SMxwhcuo5628VMng/RI7SKhAuCQQk3cPxj0dWsQmHiPpQa
        wz0rQZckUGmG3IPMw7lGOK6xI6GSm2pFGCJ5rs02uxjID3rPdChMXKW2Q==
X-ME-Sender: <xms:5NT5YkX5Wh7PGuW9RUV6kZwP6N_yMKnWfAEVih2eDHtx9JeOu7Mqkw>
    <xme:5NT5Yok8QpIr6CEGOmUi7714-28tsjiFUj3mcaDb4hpleiqoyJ4LxHpL2efs2jzis
    2fe2iBBlpzkQJksrw>
X-ME-Received: <xmr:5NT5YoY0Q1zy6N4hCNUzp_IHWiCHZdKEX0TVmm6wzQmB_JuseMTRvhI7g-7o8owFGgOWJE3BlY2na_lwEtRc_RXvo6XfSmIPw8L6aKVb5Un2hyG4G0B8lnvCtcQYkcl5gTWuWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5NT5YjUtOY7awMJmptXshxo2_O0TqOmYI6eFIgTHQvcqj5JkqrbT7Q>
    <xmx:5NT5YumhFcyOU9WS1QgLWf_C741yvbLBMqXBixGcZAq9-rXtmfxCmw>
    <xmx:5NT5YofiXyZ4gjTLH7nMwZ2b4mn1QtgKBODPPjJSF2LLlL6nzbqanA>
    <xmx:5NT5YneAvErAlT11AWkJRpqowJ5CgPA-YF6_iPHR4YWB-Bc0vLlBkQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 01:08:52 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 12/12] riscv: defconfig: Enable the Allwinner D1 platform and drivers
Date:   Mon, 15 Aug 2022 00:08:15 -0500
Message-Id: <20220815050815.22340-13-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815050815.22340-1-samuel@sholland.org>
References: <20220815050815.22340-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that several D1-based boards are supported, enable the platform in
our defconfig. Build in the drivers which are necessary to boot, such as
the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
and watchdog (which may be left enabled by the bootloader). Other common
onboard peripherals are enabled as modules.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/configs/defconfig | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index aed332a9d4ea..8f856982da87 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -25,6 +25,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
 CONFIG_PROFILING=y
+CONFIG_ARCH_SUNXI=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
@@ -118,22 +119,31 @@ CONFIG_VIRTIO_NET=y
 CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_R8169=y
+CONFIG_STMMAC_ETH=m
 CONFIG_MICROSEMI_PHY=y
 CONFIG_INPUT_MOUSEDEV=y
+CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_I2C_MV64XXX=m
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
+CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
-CONFIG_GPIOLIB=y
 CONFIG_GPIO_SIFIVE=y
+CONFIG_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_SUN4I=m
 CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -146,19 +156,30 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_SUNXI=m
+CONFIG_NOP_USB_XCEIV=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_SUN6I=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_SUN6I=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_SUN8I_DE2_CCU=m
+CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
+CONFIG_PHY_SUN4I_USB=m
+CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.35.1

