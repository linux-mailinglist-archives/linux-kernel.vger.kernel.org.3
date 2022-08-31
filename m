Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8B5A7795
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiHaHge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHaHga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:36:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DBCABD7C;
        Wed, 31 Aug 2022 00:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65614B81F15;
        Wed, 31 Aug 2022 07:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3DDC433D7;
        Wed, 31 Aug 2022 07:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661931386;
        bh=PX8yHkSXE5BpbH8BEhvTKLqiAUGh7txekQ/EyKnH4NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNLGfVMeHc6+owM+kwZbEmwwTPhTUuG3byEEMSNqekF/heVsxs8ZNrv6HzIcqos9C
         TnaTErhphNAHn5LxHKg9+Q0bC0UOPCLtHpeYB35/8gACT3gEB7il+/F8K6bRH5+Bct
         t/Hund6Nrx9CRx7SCxgS/Wps/0GBMYP/Ip7pvE3j3SbV6qEyq1dSGuXn6bk8qVfDMv
         yMZcAkH53B+em349skOP1K7zUM5/F9iLaExTUiOPgRKoBdrLFwvcdsbyJ78cwzymvw
         1fmPLy+FydaCg4THlVwDviNyK10rvof1mPnxwtnH6imJLeY/iQ1HjUwOftlu7GHusi
         PI4loU1gCX0Ow==
Received: by pali.im (Postfix)
        id F3DA6855; Wed, 31 Aug 2022 09:36:22 +0200 (CEST)
Date:   Wed, 31 Aug 2022 09:36:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Message-ID: <20220831073622.5bp3ftf3fkea5rdk@pali>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220830230012.9429-1-pali@kernel.org>
 <373fdedb-447e-b552-df83-737267068296@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <373fdedb-447e-b552-df83-737267068296@linaro.org>
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

On Wednesday 31 August 2022 10:31:22 Krzysztof Kozlowski wrote:
> On 31/08/2022 02:00, Pali Rohár wrote:
> > This new optional priority property allows to specify custom priority level
> > of reset device. Default level was always 192.
> 
> You still did not explain why do we need this. You only explained what
> you did here, which is obvious and visible from the diff. What you
> should explain is why you are doing it, what problem you are solving.
> 
> Best regards,
> Krzysztof

Look at patch 3/3, thanks.
