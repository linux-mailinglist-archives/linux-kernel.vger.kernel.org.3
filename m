Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8BA4EE4FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiDAAHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbiDAAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:07:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D8D9E87
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:05:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i11so1004410plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=Khio/oi2HtrqdMcvc0OFTth55xXyj18sfKdlvUZBmlA=;
        b=wMB6WLEsFnIPFIE6gnwfx9my88vpkp2ktJsbvuf8xrdecVKjwT4fFxlMIYo9mxE8nZ
         MCTHUow8y6NrrmXipxn7BAcYaCNpFwHMSQ+dko5HqtdeNFbQCHFzDPVRuN+fQjyIOgWR
         J31Dn+P5pYw/qVotzxL8Eb5Gv22iw/4AWYEUdlFfDvv2GmPEgHtL0sw2sLroCk4K3WEr
         Th5Rx8XGnW95Ee29SMnbC7CFmJl1gGwkl0WxQrD6vmf9koCy83oRnSkxmq9nDXQzIgK8
         eIyAEPT12GW6a7MR35Ei3diMDFH6ru52GmNtcAmKRD3XWut0rtwugOdlBSx7XPa4aW79
         JMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=Khio/oi2HtrqdMcvc0OFTth55xXyj18sfKdlvUZBmlA=;
        b=z+aKOXHQ/s6yvfDttAPz8t3ALtkLt4dE4qkTxxxXvK00DpBCEIoe8+h2kRzamQEz0x
         mnefctiMyJOZwJi5OycP5EODBqBlQjiby51u9QVLqVRz5ZugPYnUKePKKofTYKH63y6Y
         P/ORmQZrbP3j/zAlCHv/JvRh7OHae49lxqv9lV4auSD2Tco74dGDD4Xn4LPbqMVGJSqg
         44qouOH4U5QLlLcXSm2g8UIYzBkrlDV+X5ZkR8IvqjbjnxyIvBPofcYXrK6hsQqJxl5l
         ne8E6GNgyn67tPKH6jM5JKXozoHBkN/5E14UfCELy3syXcDHx0iNUNUm9DRKxgz8AV+t
         iYRQ==
X-Gm-Message-State: AOAM531bj1jagzUZoROx6t/0SSMmqDlojt96XssHKtBxsvapaS7g9VYs
        AfSrj36QL1B8E3IbKPKBPPI1Bg==
X-Google-Smtp-Source: ABdhPJxlSyyUZfGZ92VDimK6mLvmwW6qpvqtxPiNJhzAW7EuTJ7oeOE39Wrq6wyDj3XQ71sFCW4uSg==
X-Received: by 2002:a17:903:248:b0:155:ecb7:dfaf with SMTP id j8-20020a170903024800b00155ecb7dfafmr7823188plh.84.1648771517268;
        Thu, 31 Mar 2022 17:05:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a71-20020a63904a000000b00398666dcf8esm446999pge.40.2022.03.31.17.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:05:15 -0700 (PDT)
Date:   Thu, 31 Mar 2022 17:05:15 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 16:10:28 PDT (-0700)
Subject:     Re: linux-next: build warning after merge of the risc-v tree
In-Reply-To: <mhng-f46f3c64-24e0-4284-a6cb-71266e61e9ef@palmer-mbp2014>
CC:     Paul Walmsley <paul@pwsan.com>, Atish Patra <atishp@rivosinc.com>,
        atishp@atishpatra.org, Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-165544a6-8754-47cf-b57b-74bba73ac76b@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 09:46:57 PDT (-0700), Palmer Dabbelt wrote:
> On Mon, 28 Mar 2022 19:34:12 PDT (-0700), Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the risc-v tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/riscv/index.rst:5: WARNING: toctree contains reference to nonexisting document 'riscv/pmu'
>>
>> Introduced by commit
>>
>>   23b1f18326ec ("Documentation: riscv: Remove the old documentation")
>>
>> This is actually in Linus' tree.  Sorry I missed it when it was
>> introduced.
>
> I guess I missed it too.  I just sent a patch to fix it up.

Coming around to the fix reminds me that I should have asked what you're 
running to trigger these, as I should probably add it to my tests.
