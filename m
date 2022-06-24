Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E784355A436
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiFXWLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiFXWLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:11:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068087D4F;
        Fri, 24 Jun 2022 15:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87C20CE2E73;
        Fri, 24 Jun 2022 22:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99D5C34114;
        Fri, 24 Jun 2022 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656108705;
        bh=zC/TQWUhx14RtF6bjzwQYVG5JLJVewaK3p4NYDij21Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BaTjWfs9C735LFyrl6I271K+mk1XSXmVOE143ZHBWY8j6FmF/wAVXr8+zA+cAdbxJ
         QNctVsMV6/cWh3ASXWoaaQKStPbnXXOuNhqrkuoX1d7RvXRX4L62nQNeKo1lP4NTwN
         xz7NSySEbcp5L7bh6Yca0Nwcm8gfzoB72UVHVKyepN4m+9yljdFYvVTNDT4tmiDVfy
         BOOs1fviabeKc64dupMTlq1625dpVgO/jta+R+OOnIupO2vr6DIvq/iNr8vNSvImTL
         iU4iv3DB4j9J5teg9ICQ+TUyogCkFBIxcNJR6RQM59IkP/Lm9kVCZFPeYBt/qWFtdZ
         WxY8bFVJhLQWw==
Message-ID: <53402d57-ee3f-59b9-a8dc-59fa659f3662@kernel.org>
Date:   Fri, 24 Jun 2022 15:11:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND v9 1/5] arc: dts: Harmonize EHCI/OHCI DT nodes name
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-2-Sergey.Semin@baikalelectronics.ru>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220624141622.7149-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/24/22 07:16, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?"  . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
>
> Signed-off-by: Serge Semin<Sergey.Semin@baikalelectronics.ru>
> Acked-by: Alexey Brodkin<abrodkin@synopsys.com>
> Acked-by: Krzysztof Kozlowski<krzk@kernel.org>

This slipped thru cracks. Now on for-curr.

Thx,
-Vineet
