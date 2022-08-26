Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA65A3259
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiHZXGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiHZXGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:06:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12CF7F0A5;
        Fri, 26 Aug 2022 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5v89HB59ceXORCXn0IdNTCqonvq1Ynym1Eh0Nl22wmg=; b=Lv+FpwYyAoN1URDxR9JSQT/z2w
        4x+Uu41MqPITR8t2o+mHXJBXO80BR9733RWvVX3r4MKngIgzu7gXcdELpv+ysdPNYkcqySy9vbNV0
        2Xc6AeOMZo3L/UE3m992HDTX4VmjATFDixwtMtOjcwVbuEz3/Lrcp2RI1C2VN4X/SkT21BTIZxMwc
        LPQ0I61KnhF5f9Bf27AfaMSSiOOHEtsNEjKwRwsYdtKMbXI2ga9YLrzH/R5f35Ns1KI+BIQtp+JnH
        C3JteM+1n74rvprvAQUEGOG5YeLncyuJTB+owNhYxkFZJjTwax3NVMQkOF2MPdhishBblPH+tG6wj
        64DGJGFQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRiP1-00EzUv-A5; Fri, 26 Aug 2022 23:06:15 +0000
Message-ID: <d785f8aa-5a41-006d-394c-2bba64047cb4@infradead.org>
Date:   Fri, 26 Aug 2022 16:06:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4] Remove duplicated words across the whole documentation
Content-Language: en-US
To:     Jules Maselbas <jmaselbas@kalray.eu>, linux-kernel@vger.kernel.org
Cc:     Conor.Dooley@microchip.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org
References: <20220826163458.1142-1-jmaselbas@kalray.eu>
 <20220826165634.5617-1-jmaselbas@kalray.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220826165634.5617-1-jmaselbas@kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jules,

On 8/26/22 09:56, Jules Maselbas wrote:
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index f1f4e6a85a29..6a0c2cc722eb 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -161,7 +161,7 @@ The switchdev driver can know a particular port's position in the topology by
>  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>  bond will see it's upper master change.  If that bond is moved into a bridge,
>  the bond's upper master will change.  And so on.  The driver will track such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by

I don't think any change is needed here.
The rest look good to me.

>  registering for netdevice events and acting on NETDEV_CHANGEUPPER.


> There are likely more duplicated words.

/methinks that you have barely scratched the surface.  :)

-- 
~Randy
