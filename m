Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617F44F78D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiDGIEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbiDGIDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E277C1575AC;
        Thu,  7 Apr 2022 01:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DEFB61E9C;
        Thu,  7 Apr 2022 08:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935E9C385A4;
        Thu,  7 Apr 2022 08:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649318477;
        bh=rXlzViCFaC+xoZUZ/5dyGf0DsTW1RH+U5PQqazQNM78=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EPJSqSDgdnI5Jd4YwMBYCA/uHa32dYMlbfV4KCsCcxR9OOI86jL108jQT+TsVvjPT
         WImzj9N9xbi8jlzUJHvVVbW3E7Ns5LGYR2nnXp547WDnsBZOllWC5sikDQbdARBnAT
         Yy9jZpt3K0XpNa26kcrUM2JjRW6fjBk9JUY1/ry9VKOtu7Wpj1OAB3/0aJjsyLfuhz
         IJvBR6JkvTSFJfGD8MGEfcHFbINjSEAV3Q5+zKY+Nq+ZlNa8MuQ6LEOUYoRImip+N3
         1a36dkEewbr4prWXM7IOHvFu+1hfkNQT8jxSRvQCmqbBbeWAb2Pf3k+NhCRQ41ibZr
         YIe5ehPKxk9jw==
Message-ID: <59464d43-189f-9637-8660-a8cd7e769eff@kernel.org>
Date:   Thu, 7 Apr 2022 11:01:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406135214.6989-1-a-govindraju@ti.com>
 <20220406135214.6989-2-a-govindraju@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220406135214.6989-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2022 16:52, Aswath Govindraju wrote:
> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
> controller.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---

Reviewed-by: Roger Quadros <rogerq@kernel.org>

--
cheers,
-roger
