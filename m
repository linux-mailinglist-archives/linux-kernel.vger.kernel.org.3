Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1E51148D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiD0Jpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiD0Jpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:45:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E27276101;
        Wed, 27 Apr 2022 02:42:18 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7A5D422249;
        Wed, 27 Apr 2022 11:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651052253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKsiQAb3VLl9KkgR7RnW8se85eQh8HxNJ+rM3PCF52c=;
        b=abu1OzKE11hlOadwfQD2A00Fv+d+92VqVjFPYqpna1lP6pxC4Wl3ZLso+0HSdS/KdnLnnB
        qNA2LLNjdxvhlRbvP1GCH9ZhzwSCvf9gcYviQSuK16wp95YZcuW68r30EeTti6fs07vvHR
        7O6TbZRkoDyWd2qhcZFCjvMdgHTm5Wk=
From:   Michael Walle <michael@walle.cc>
To:     jerry.huang@nxp.com
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 1/3 v5] dt-bindings: dspi: added for MikcroBus socket
Date:   Wed, 27 Apr 2022 11:37:27 +0200
Message-Id: <20220427093727.1244218-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426022413.885092-1-jerry.huang@nxp.com>
References: <20220426022413.885092-1-jerry.huang@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> changes in v5:
>   - rename compatible name to mikcroe,mikcroe-socket
> changes in v4:
>   - rename example node, adjust description
> changes in v3:
>   - add the dt-bindings

Please keep people who reply to your patches on CC in the next versions.

Thanks,
-michael
