Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAF4D05E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbiCGSEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbiCGSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:04:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B74EA3D;
        Mon,  7 Mar 2022 10:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD078612CE;
        Mon,  7 Mar 2022 18:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE4DC340F6;
        Mon,  7 Mar 2022 18:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646676220;
        bh=GroBZq5f9ydM0k881i6/q8HA2YBB5lbcWXHdWwi9oEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VZv892sUwGARHDj+GY7H6M676BMAGIHmkA0BmAKxWKaSxrfsUGm4yjD0WDHXFEc5l
         m2fU9mC0K4EZ/Ub+HVbTiWJejn75h8mVwmtQ96fo+wDfMArr46NmvqqOxB3gSPMXT3
         bz3XtbaVQj23r82vdBxkCc5LdZs6cWn55iO9iYJBrvRJUhsYIxP1Vz19TgVf3Gyr6W
         zXe7f2yuvVv6dA9Wn/quxONzGtTwdiDUk2ALsB7GXW/bpslRs3PblT67Mwp3POxF/R
         nFhjFe4qWU5w8pXr55/De8kItH6iEkS0MiqjSFw0oPHC0Y8e+z1M+gx0BpK/qVkvEs
         4rVrGIr+g+rRg==
Received: by mail-ed1-f44.google.com with SMTP id q17so21118252edd.4;
        Mon, 07 Mar 2022 10:03:39 -0800 (PST)
X-Gm-Message-State: AOAM5310q0eBeyDslrXwifVCN/uQK79KUNpgfAdkD6HF9on4bQKU8+3e
        54D862mWixbLkh3lxMLGac5qBVay/MEPfUkqHw==
X-Google-Smtp-Source: ABdhPJyFuI/fg6RMtF1oAdFB4y+D9IZhG87aW9IlKhHbcqAMXheFmUXB6WhCL2/DsQNWoPooxUAVoIpIywyXTL9oAxQ=
X-Received: by 2002:a05:6402:51cb:b0:409:e99f:bc1c with SMTP id
 r11-20020a05640251cb00b00409e99fbc1cmr12439878edd.68.1646676218348; Mon, 07
 Mar 2022 10:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20220307172901.156929-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307172901.156929-1-krzysztof.kozlowski@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Mar 2022 12:03:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ufttuegvW_STJ7yjDY_5TRAuLNqfAAxR9gjrqtbMP8w@mail.gmail.com>
Message-ID: <CAL_Jsq+ufttuegvW_STJ7yjDY_5TRAuLNqfAAxR9gjrqtbMP8w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: dt-bindings: update Krzysztof Kozlowski's email
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 11:29 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Use Krzysztof Kozlowski's @kernel.org account in dt-bindings maintainer
> entry.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> ---
>
> Hi Rob,
>
> Could you take this one directly (optionally squash with the patch
> adding me as maintainer)?
>
> My email address also appears in the bindings. For now mailmap will
> handle it (see my other commit). I will change it after merge window,
> because some of the bindings are in separate for-next branches.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e88b4e17e35..48b0cf606be0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14604,7 +14604,7 @@ F:      scripts/dtc/
>
>  OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
>  M:     Rob Herring <robh+dt@kernel.org>
> -M:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +M:     Krzysztof Kozlowski <krzk+dt@kernel.org>

FWIW, the +dt never really worked that well for me. I've concluded
that anything that relies on submitters getting things right doesn't
work.

Rob
