Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A355FEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiF2Li5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiF2Liy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:38:54 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9503E5D0;
        Wed, 29 Jun 2022 04:38:51 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4BB6FFF80D;
        Wed, 29 Jun 2022 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656502729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fU1llwwXY0ybC66qxXpHVtoRu9HLSB96OOB8Toq8OMY=;
        b=PSThL+dv+sNkjFPfH38c7TXkzDpfk35XSxmgR5grGF3EZfOyL4Aok/axiwmZd0epblRNY+
        Ig8gW7wlLSn5d8Pgs5uIEhsPBpwtp8UmeeQr4WRLjZvGVfZsRgymQNI4NxMmhUSpLlQh2w
        2Th9hAD79+FG+VGLesaX6BF8q/cUnDL+ZagjnXFq6K02ufi5QGOlcafH4Jc8mNi9NvT6pw
        WcyYKtBjDEkAepHjeNgKTEWU1MqbNMwiF1NPfU8EZOE1wnU/83Mcgww2eLTMfoQGyS1Jgf
        iteNycL6Yee4niS2jzPhvuuVy8dsEbp++IPHmXFcs4zlypkpNoo83KuHtFaYJA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?b?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: mtd: partitions: add additional example for qcom,smem-part
Date:   Wed, 29 Jun 2022 13:38:47 +0200
Message-Id: <20220629113847.283696-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622010628.30414-3-ansuelsmth@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'dd638202dfb6507cd529751b6c39680c292e245e'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 01:06:27 UTC, Christian Marangi wrote:
> Add additional example for qcom,smem-part to declare a dynamic
> partition to provide NVMEM cells for the commonly ART partition
> provided by this parser.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
