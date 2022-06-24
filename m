Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8F55A0CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiFXS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXS0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:26:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65877FFD;
        Fri, 24 Jun 2022 11:26:34 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7836066017DF;
        Fri, 24 Jun 2022 19:26:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656095193;
        bh=3JB1GgNrKV4fJFiSyBLBNDtbG90NzfxBMJHl6mKODBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rlf89ZSBbrPksiZjYRU62RDtXMA1jiKQI60SGGBuscOB8hio++rjRz6Of6IRbDU1H
         8x8q0ExI/UNT3zDI8c8Hv4ID4HTbnRJBUOh8tJEQpEzfITdoao9P+h4T4qgRQnMZqc
         yA00Pp3ZSDTzP4N0dZVmuwluKRjTdVBOoqBMompzm9BzZ97GuzcZB6eP/kG0o5/EbF
         mZv1CzAhz9azqgd/uCpKD++9lOeN+PhfGBjLAwka3xDdQDtp18Ma9/B22yTX3gFUa2
         +4WTIoPwSX/EnrbpD4g7eAEkgrJluOL7T1Pvp/XxKz9nRBMZCddhs4xJKcNTJJR4gH
         Jf4T+HPq0jAkw==
Date:   Fri, 24 Jun 2022 14:26:27 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 2/5] pinctrl: mediatek: add drive for I2C related pins
 on mt8192
Message-ID: <20220624182627.nzz5js4ndcq4a3ig@notapiano>
References: <20220624133700.15487-1-guodong.liu@mediatek.com>
 <20220624133700.15487-3-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624133700.15487-3-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 09:36:57PM +0800, Guodong Liu wrote:
> This patch provides the advanced drive raw data setting version
> for I2C used pins on mt8192.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
