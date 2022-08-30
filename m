Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B75A5B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiH3Fbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH3Fbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B557EFEC;
        Mon, 29 Aug 2022 22:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF69612BE;
        Tue, 30 Aug 2022 05:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E09C433D7;
        Tue, 30 Aug 2022 05:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661837502;
        bh=Cx//WqmvDiWDeKFb5xhwU9eZb4oNMLT8lWSoQd+h7DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qG2/my20lNiK0+vesCAaDiUl1ZWIEc8nF3w9EzgBlBb1bqT7gEQ6csv+MVKxwdsz5
         1yMAgeKOR794G8nxXrWuTKzfxwjR7KZjd4d+qNm7TRDEYkpHiOp+W38Pi/rCKUOGdn
         X/2octNE70WxoSymCj/fU2N9KJGcjn+ie1IDSD1OAogTVYHkvsYPl4leUgux3eBroR
         AzReZNWsan1phPkH4czWlm6bLV/j0c+DyiMMqYVn+9xwHal67rRmviO84+d4/pEylh
         ewazfk/vauHRP2AuCFkE1TOmlMgU+Z1xhoZQkm41VVqwnuDKWWWBG1KhpaW1cxM7m2
         Ww8iwP33iP96g==
Date:   Tue, 30 Aug 2022 11:01:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] phy: qcom: edp: Introduce SC8280XP support
Message-ID: <Yw2gut71lb8h2lLb@matsya>
References: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-22, 21:07, Bjorn Andersson wrote:
> What the subject says.

:-)


Applied, thanks

-- 
~Vinod
