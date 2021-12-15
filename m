Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB44475CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhLOQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhLOQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:06:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E0C061574;
        Wed, 15 Dec 2021 08:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47AF261896;
        Wed, 15 Dec 2021 16:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCED1C36AE0;
        Wed, 15 Dec 2021 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639584374;
        bh=AjuTnNgNxVdmHoft5M30nv8knZSADAbtJTguw/b7p4Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OELkQLmgmPrkq7vA21O3IjhRnMHnLFa9HBWVwxj8XzHgqnYFCmbu45yEtKn/rVAU3
         JtAKap3dgPqytjJtPIahsbsBr178jxsxk8Fh/gXpR3f58oYgWQYde2oGlsYeVafNb7
         nMAOuQrlatdG3EzQ/HEo3bawDM0O9q9H8n2V3Lxl/nPBZCvY9TVhZErNwnp4O75s/1
         GirO8kb/PnYSX2scEkgR14NVAohF0kvWKtPf74VKI1xgRMhC7GfcoxMgieeGdwcZTI
         LPk+B1L/qp0w0e7QWzcC5wg7DTgJ2ZRYzYwh4slFnMwg6P91CcDxPXHxntKEzJk6ky
         4f/MsZMAUDc2Q==
Message-ID: <afb20c0909008ae4794a8c2608a7a6c643d11263.camel@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to
 json-schema
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     stefan.wahren@i2se.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 15 Dec 2021 17:06:09 +0100
In-Reply-To: <YboOPd/xYWkL2JrJ@robh.at.kernel.org>
References: <20211215094448.280796-1-nsaenz@kernel.org>
         <YboOPd/xYWkL2JrJ@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 2021-12-15 at 09:48 -0600, Rob Herring wrote:
> On Wed, Dec 15, 2021 at 10:44:49AM +0100, Nicolas Saenz Julienne wrote:
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> > 
> > This converts the VCHIQ bindings to YAML format.
> 
> Am I supposed to review this? Some version of it is already in 
> linux-next...

It's been removed from linux-next for the time being. There was some issues
with the previous binding, namely the fact that it removed the fallback to
'bcrm,bcm2835-vchiq' on BCM2836/BCM2837. All in all, having it is harmless and
might avoid regressions on some OSs.

Regards,
Nicolas
