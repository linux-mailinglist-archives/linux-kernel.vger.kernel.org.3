Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B650DB08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiDYI0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiDYIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:25:47 -0400
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 01:22:40 PDT
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B513D27;
        Mon, 25 Apr 2022 01:22:37 -0700 (PDT)
Received: from Seans-MBP.hinnerup (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id CAF3212432D2;
        Mon, 25 Apr 2022 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1650874531; bh=6Ehw2h/U2zhJQbdgpEFAHbqFjaqCyqoE/PqGYlcgo2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Qr9be19FIiCVXW3W6iz9AtWLd/d0wGOHMpvjpFzyEVQJTfWY1Lt6wPEuImkVW3Ake
         7MnSfWXpP8LN71PrD37YM1FpavFbE1UOYBn/OVuuxzZ1aS30VVi+Z+CkHu8v2tETRU
         p0OI39l5GlUtXtJR8JEP6eRcCGHEsHGtBXpTb2Q4SZ98yKGmHAiGi0bSztjo9d1el3
         2ZxQ5BweDb6WurlYy52NlOW7wmYaD6Wc6fYRNaZHI/cSHf/Eh5j++7qIBrlp8QCQlK
         n2Tuw7goBSC94KCNrx+ZjB6c5Et+UalMVNQeBPL76tW7Np+S7WnZK74wvCQwyn4I/w
         0zDIIfJbyCVyg==
Date:   Mon, 25 Apr 2022 10:15:30 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ti-dac5571: Add ti,dac121c081
Message-ID: <20220425081530.pscgia54fy6h5lfl@Seans-MBP.hinnerup>
References: <b657ebf9-e2e3-6d3f-e7e9-c660e860e54c@axentia.se>
 <90204a08-0c88-6c21-1492-6a5330184096@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90204a08-0c88-6c21-1492-6a5330184096@axentia.se>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:02:25AM +0200, Peter Rosin wrote:
> It works much the same as ti,dac7571, so it fits in the "family" even
> if the name is a little bit different.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> index 714191724f7c..88298bc43b81 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> @@ -21,6 +21,7 @@ properties:
>        - ti,dac5573
>        - ti,dac6573
>        - ti,dac7573
> +      - ti,dac121c081
>    reg:
>      maxItems: 1
> -- 
> 2.20.1
> 
