Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D44FE5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357690AbiDLQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiDLQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:40:38 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9310C1BEAE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:38:20 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id B4DED2536E;
        Tue, 12 Apr 2022 16:38:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id CB08922;
        Tue, 12 Apr 2022 16:38:11 +0000 (UTC)
Message-ID: <38692bbdd535dfe249babd1eb6aca24b2e1070e8.camel@perches.com>
Subject: Re: [PATCH 4/5] MAINTAINERS: update MAINTAINERS file
From:   Joe Perches <joe@perches.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     Samyon Furman <samyon.furman@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Tomer Yacoby <tomer.yacoby@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Apr 2022 09:38:09 -0700
In-Reply-To: <20220411172815.20916-5-william.zhang@broadcom.com>
References: <20220411172815.20916-1-william.zhang@broadcom.com>
         <20220411172815.20916-5-william.zhang@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CB08922
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 59qrfu693xokzw7ai9f6zsi1gbgxqqed
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1926vEBFWIjUSOwGm9YLGj7cPVOg3NK36c=
X-HE-Tag: 1649781491-409073
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-11 at 10:28 -0700, William Zhang wrote:
> Add maintainters, SCM tree, files and directories for the new BCMBCA

typo of maintainers

> arch. Only add 47622 for this change and will update in the future
> when more SoCs are supported.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3740,6 +3740,20 @@ F:	drivers/net/dsa/bcm_sf2*
>  F:	include/linux/dsa/brcm.h
>  F:	include/linux/platform_data/b53.h
>  
> +BROADCOM BCMBCA ARM ARCHITECTURE
> +M:	William Zhang <william.zhang@broadcom.com>
> +M:	Anand Gore <anand.gore@broadcom.com>
> +M:	Kursad Oney <kursad.oney@broadcom.com>
> +M:	bcm-kernel-feedback-list@broadcom.com

Unnamed exploders are not maintainers.

Maybe:

R:	Broadcom BCMBCA reviewers <bcm-kernel-feedback-list@broadcom.com>

> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +T:	git git://github.com/broadcom/stblinux.git
> +F:	Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> +F:	arch/arm/boot/dts/bcm47622.dtsi
> +F:	arch/arm/boot/dts/bcm947622.dts
> +N:	bcmbca
> +N:	bcm[9]?47622

bcm9?47622 is simpler, though it doesn't seem this is actually useful.
Where is it actually used in files other than the ones already listed?


