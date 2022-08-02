Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7D587D09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiHBNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiHBNYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:24:45 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2744E15A37;
        Tue,  2 Aug 2022 06:24:44 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Aug 2022 22:24:43 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 7326320584CE;
        Tue,  2 Aug 2022 22:24:43 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 2 Aug 2022 22:24:43 +0900
Received: from [10.212.181.253] (unknown [10.212.181.253])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6BAA8B62A4;
        Tue,  2 Aug 2022 22:24:42 +0900 (JST)
Subject: Re: [PATCH 0/9] Update UniPhier armv8 devicetree
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1656894074-15751-1-git-send-email-hayashi.kunihiko@socionext.com>
 <0a0a64a7-60cc-e95d-c2e3-3c11a53a6527@socionext.com>
 <CAK8P3a0egd9dupLFid9CsSygQyTK3KopB8m5LVgnUW9L1cF6JA@mail.gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <fd6e9539-4c67-93a2-9104-018ed9703ff9@socionext.com>
Date:   Tue, 2 Aug 2022 22:24:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0egd9dupLFid9CsSygQyTK3KopB8m5LVgnUW9L1cF6JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for your reply.

On 2022/07/30 21:03, Arnd Bergmann wrote:
> On Fri, Jul 29, 2022 at 11:52 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>> On 2022/07/04 9:21, Kunihiko Hayashi wrote:
>>> Update devicetree sources for UniPhier armv8 SoCs to remove dtschema
>>> warnings, add support existing features that haven't yet been
>>> described, and replace constants with macros.
>>
>> If there is nothing wrong with this series and armv7 DT series,
>> I'd like to make a pull request.
>> If the request is late, carry it over to the next version.
>>
>> How about that?
> 
> The timing is not great, as normal updates should get merged as parts
> of the normal
> pull requests, which I have already sent.

I understand it was late.

> A lot of the changes can be considered bugfixes, and I would still
> merge them if you
> think they are harmless and can fix things. In this case, also mark them as
> 'Cc: stable@vger.kernel.org' to be backported into lts kernels. Anything
> that
> does not qualify as a bugfix should now go into the 5.21 merge window.
> 
> Please send the bugfix pull request as soon as you can so we can merge that
> early. The other updates should be rebased onto v5.20-rc1 once that is
> released in about two weeks.

There are one bugfix patch for each series and they will be sent for "stable".
About the other patches, I'll rebase and send them again.

Thank you,

---
Best Regards
Kunihiko Hayashi
