Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EAA4FF8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiDMO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiDMO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:29:16 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACB5620E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:26:53 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a14so667599uan.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=43J0yXvH4ROwR66NzzY2ROnhEkvw7zmvsdv9tyaOFBg=;
        b=okZaRwO9PClWxdq/tG6n1MhoNff5DO91mf2h91Fv0qP6Slpej8oQRbqr3Ybd9So6kl
         3gtLFqJs/KEgyJYrdlEvi04JtWHoIjS+U5e7FM/9k1E6JHScQeSCimgmZi8veMTWrM+2
         LDVXgjFffEnlRST3oXr2RtELLVSBecz6h0kbdvGkbjfz2p4254S5QaCbkh6WAVv/4ekI
         9w1MHeEI1TqD04pNHba3SECbyJEcjh9Yj5QukWq3SYQgcLZC5I+ViywYZP7yWILPxJkl
         xQ/iRlmlA94YKvbbv/WTaWlYUFTPLr2zE8QPX/d6Lthw4YZ6UcDLUPJAWHZ+fSNtlHj/
         fZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=43J0yXvH4ROwR66NzzY2ROnhEkvw7zmvsdv9tyaOFBg=;
        b=Rr74yswe5etfgy14TU6FGJBXdMcVI9jjF9bhpsvX8gfPyb1ef1uitBbRLMBXaQ1noh
         YUgswekP0YE+OxSfPkV3noea3bTHQT/csDo0bgxmpSw6awCII07rx2VNFT2B0zcXoshC
         Z9kxW3LKuD3Z1OqY6xYajqfkavpYkXd/UPrE60KDVswEkImePhrr55W6u9SYiT6fSPs+
         yZ6L+euEf3K0Y9oPEOg/rvABV/C8IpOcOu7KAXRLXBzHhkyxl2pF0IgCIeDQIfywcukO
         zsBXlzBBYcSXhtUq0BP5dEDvr/S15i+Fi5AaGRTMXzKf07nXeq2IrilGLnM5KwDvVMYi
         820Q==
X-Gm-Message-State: AOAM532kHNVTZec2JACgpR0FTgos1nEITj7XH9o/lNXDe1eYXMWk1Dtj
        WaJg3nyLlBLOV0Aq+wPjibk7v9UqiS5ZoQzN/T0=
X-Google-Smtp-Source: ABdhPJz1qHyripY7pUrpl0qeWv2kRzlcs6xlv+JcnNk5x17s1QBsn+NugZQITJFrxE054itlevbyEB6udiBPFY2kgoM=
X-Received: by 2002:a9f:31f1:0:b0:357:9034:2afc with SMTP id
 w46-20020a9f31f1000000b0035790342afcmr3286870uad.11.1649860012506; Wed, 13
 Apr 2022 07:26:52 -0700 (PDT)
MIME-Version: 1.0
Sender: anselmenicki@gmail.com
Received: by 2002:a59:db5a:0:b0:2a3:6f2a:6536 with HTTP; Wed, 13 Apr 2022
 07:26:51 -0700 (PDT)
From:   John Kumor <owo219901@gmail.com>
Date:   Wed, 13 Apr 2022 14:26:51 +0000
X-Google-Sender-Auth: 4cITI-vIcGWnaCZGCqcwFh5W_Ko
Message-ID: <CANbcXbEJX7QO12iUr1zQqVJ3-eqTNgrgP4DTGiHooC3Bs1vSKA@mail.gmail.com>
Subject: Reply me BACK.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My dear,
Greetings! I trust that all is well with you and your family. Did you
receive my previous email?
Regards
Attorney John,
