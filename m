Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E544451D7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiEFMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392169AbiEFMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:34:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2086929A;
        Fri,  6 May 2022 05:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39556B83312;
        Fri,  6 May 2022 12:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77830C385A9;
        Fri,  6 May 2022 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651840173;
        bh=3bpp18OWZ72TvC/61yq2g1DOVEtz9lPvzUh+fW+K5oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOBpClagO+LR7HTDxGuEubMyCjApld7o/Y8uB7AySN4azFHASbzI54ALvSr73Y4Yp
         Tifq03zS4mZd4zs6PQMuUN2YjvMauRUbBDzglAvFkMFgJHPiIZ41SIVuyyH8rVSMEd
         gxfbUuUK4hjOP8LewtXRX0t6UgaSsUePh/UuYSGkU5w69fBDhjULf4ASbNkNdVlpRA
         NDl3vABQ7rpizjRSjWDQcQ9S4tIukSXk0FvJ0tH5EFfTVFupadMfiVdwQJ8S08xIuo
         G6c6cuQY2cMQvv40zuQJnA3DG2DxtZJ9zUTvaKwhhXSuYI8VbRxYgAKUf8pU4x1Dvx
         0VpCQYNrUJS2Q==
Date:   Fri, 6 May 2022 20:29:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philip Oberfichtner <pro@denx.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.winker@de.bosch.com
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: Add bosch acc board
Message-ID: <20220506122925.GK14615@dragon>
References: <20220506055948.971924-1-pro@denx.de>
 <20220506055948.971924-3-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506055948.971924-3-pro@denx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 07:59:47AM +0200, Philip Oberfichtner wrote:
> Add device tree binding for the Bosch ACC board, based on i.MX6 Dual.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied 3/4, 4/4, thanks!
