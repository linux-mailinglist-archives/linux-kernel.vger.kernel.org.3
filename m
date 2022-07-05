Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF50566A99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiGEMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiGEMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1531834C;
        Tue,  5 Jul 2022 05:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1694C617B1;
        Tue,  5 Jul 2022 12:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F1C341C7;
        Tue,  5 Jul 2022 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657022402;
        bh=P7/TRblLUfM9RD1xaDdnyulOyhjawodBZp2WEwoB/2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+vTQpGec7eEqrXJlNGvgvWFMW1zxJkDtuqSVybOfmR1QR4KHBYmS/z0BQvJ+TnJe
         qhoJ/L4nNOzsT79QEmWakl5WX8Kke40NnWlejH6MsMTS8PFujVR1XCVPPYkNsg4BkH
         1dkieZ5Cmx21KjP5UZh6zIrul8jQgLreIwl0Ir7DNsX4q9lc5WAqwkuKfIUBE7mSfy
         G4z9kVK0HaeW8LxrUWbYDh1XFnBa6dEPAJYY1YnoLXXVcWWvWs/L6hF2XSUA+Y3hYF
         x4eskdnHcGyTJqcs7LAUzraZVbC/P+mmMQipGqHgY3U1fZ2antvH1RFnKg2tLbjD7s
         zxPQphHyCUFeA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8hDn-000689-28; Tue, 05 Jul 2022 14:00:03 +0200
Date:   Tue, 5 Jul 2022 14:00:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: add
 example node
Message-ID: <YsQnwyyXcffNlkLT@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-10-johan+linaro@kernel.org>
 <8271f4d5-e12e-ddf0-46ab-86a39577755a@linaro.org>
 <YsQQ2o8aYJnnWuNa@hovoldconsulting.com>
 <3b91ee2f-3e87-c18c-aa04-2cd93273b63f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b91ee2f-3e87-c18c-aa04-2cd93273b63f@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:32:30PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 12:22, Johan Hovold wrote:
> > On Tue, Jul 05, 2022 at 12:10:29PM +0200, Krzysztof Kozlowski wrote:
> >> On 05/07/2022 11:42, Johan Hovold wrote:
> >>> Add an example node based on a cleaned up version of msm8996.dtsi.
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>
> >> Squash it, please.
> > 
> > Why? It's a new addition to the schema.
> 
> Because it is not really new. When you add new bindings or convert
> existing ones (without example), it is expected that example is within
> that commit. You do here the same - add entirely new file. Old file had
> example and the bindings. You now split some pieces, convert it, so new
> file is also expected to come with the bindings.
> 
> The same as there is no point to make half-TXT-YAML conversion, there is
> no point in half-split of existing bindings. Either this split is
> correct and complete, or it's not a finished commit and we do not commit
> half-commits.

Fair enough, I'll squash the examples in.

Thanks for the quick review.

Johan
