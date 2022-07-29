Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E43584DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiG2Isb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiG2Is1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:48:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E43C483205;
        Fri, 29 Jul 2022 01:48:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D1BD1063;
        Fri, 29 Jul 2022 01:48:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66DE3F73B;
        Fri, 29 Jul 2022 01:48:22 -0700 (PDT)
Date:   Fri, 29 Jul 2022 09:48:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt
 optional
Message-ID: <20220729084820.73mnj2wwd65eey6x@bogus>
References: <20220728190810.1290857-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728190810.1290857-1-robh@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 01:08:10PM -0600, Rob Herring wrote:
> The secure interrupt is only useful to secure world, therefore for NS
> users it shouldn't be required. Make it optional.
> 
> This fixes a warning on Arm Juno board:
> 
> mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
>

Reviewed-by:  Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
