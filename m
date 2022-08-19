Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9924459958A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346368AbiHSG41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiHSG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F59DEB74;
        Thu, 18 Aug 2022 23:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 198B761645;
        Fri, 19 Aug 2022 06:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2E5C433C1;
        Fri, 19 Aug 2022 06:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660892183;
        bh=pohykInq31JBkldU8Jz/BkVsWub0VBSAahB2HuQ7iI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLZ14YAr4yU6xRZqEyCcFZOqQzweZUfvzKbS7G7DJ9Lq+GpIVdr2tsjaiLyKLoBty
         Ksj8Zd0ki338ZV7gXjnLpzfZiaTPjKlBS56hdP3yluz2o1UTT6FsSizULk8gCLJ55f
         U1VtyxVWxS+wji2nhKJ0M6l+pFKdOBXoVN3HaXf8Cs1mmoCoGmiAGSs/8PzF5LIjAY
         IlexXL3hSFW6t7n71DTWEMFGQYPSk+HMygo4s0riV+JeWwmxwaQP9+s8oIHbmKEY6h
         GuKGk9yGCs3fkXAq6aALSw+aOjaxc5hna5S60nKaHeXpeyL00O41rCeZEQd7ZkblJI
         IUOgGLVxBPHqQ==
Received: by pali.im (Postfix)
        id 49EEB761; Fri, 19 Aug 2022 08:56:20 +0200 (CEST)
Date:   Fri, 19 Aug 2022 08:56:20 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add active-low
 property
Message-ID: <20220819065620.wvmy3kigvvbwo4bo@pali>
References: <20220818172528.23062-1-pali@kernel.org>
 <f635d5a7-6817-cd62-e395-63e346775716@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f635d5a7-6817-cd62-e395-63e346775716@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 August 2022 09:46:56 Krzysztof Kozlowski wrote:
> Although the question is - where is the user of it?

I was planning to send updated powerpc DTS files with these
register-bit-led definitions after accepting dt bindings.
