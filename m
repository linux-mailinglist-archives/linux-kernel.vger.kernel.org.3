Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856D847C865
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhLUUsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:48:52 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201CAC061574;
        Tue, 21 Dec 2021 12:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=52nPiLeCIbzbs31AEDsXVWz0++v57IOwZujp1/Gj768=;
        t=1640119732; x=1641329332; b=kPlwQxzuv9B8AWNCnyZ3uGveJZYtc7CAqyHYhRV/X4lbiYp
        G9LR76ezsBc2I4ItYerEMVQ+iKJz95o/GgGsW7ZIGJK/0Eot2FAJY3UTzpDp8mZ5cy4NOWX+KGZAQ
        IXZJzv3jyOEEMtjWJqKufmzwk3tryP7D8sDWvk2IY+KgSKUYJXBRwrsnwJI77Opyj6nSkkIZIlKiy
        2aZXNN3UxCbypAjaUpt7ueKnKJ3m9avmaJJmUajamg9nBFZZEN8CjNu2jxNK30VSyAAe2J4dybsGl
        vNX1KtlTh8KrWe+U/oyRUo89WCx44DAfSZ++dJIXe/1tso58cxN/CdqVSy0UddoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzm3g-00Eijv-7p;
        Tue, 21 Dec 2021 21:48:28 +0100
Message-ID: <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virtio_uml: allow probing from devicetree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@axis.com, devicetree@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Dec 2021 21:48:26 +0100
In-Reply-To: <20211221090447.1567-1-vincent.whitchurch@axis.com>
References: <20211221090447.1567-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-21 at 10:04 +0100, Vincent Whitchurch wrote:
> Allow the virtio_uml device to be probed from the devicetree so that
> sub-devices can be specified using the standard virtio bindings, for
> example:
> 
>   virtio@1 {
>     compatible = "virtio,uml";
>     socket-path = "i2c.sock";
>     virtio-device-id = <0x22>;
> 

Given this, maybe it should modify
Documentation/devicetree/bindings/virtio/virtio-device.yaml? Or actually
add a new Documentation/devicetree/bindings/virtio/uml.yaml I guess?

+Rob, because I'm not really into any of this.

Also, I'm not even sure we should/need to document the DT bits that are
basically only used for testing in the first place?

Code looks good to me.

johannes
