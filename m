Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC8505F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiDRWOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiDRWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:14:42 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81627B24
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:12:02 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 80so6535733vkw.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nNiF/cfpv32eI7WiEbUPrw8St0XMYF92yshDZXr8h2E=;
        b=QBHDzIr9CfCuodmwGTnH3uS+W5D7taUDC+XMZM8ck4qoqU9WalR68HZEoHWLPxNyXj
         IGVNsDH7fr5cN/2mjChGi34LL3yvPDRyyrpyv95p0z8kPR6WBvzb/vy7/+igTnPZitqE
         8AE1JKPiopTReNvJjhjI0DmxqJOMwvQw2b2KwUW5LvDJ5gMCYaMovM2GcgP4SkRijCui
         TWjmj4wJJozyWg0NAe99qfffw+e5Buf8olUfIud2L1Fi16K/I+nJfjZYZJDuCOvoP/Xe
         Zg50gXv+KDh5nZ19Q7r+D3vqmlSBFrBZq0Nom8W6spzsAJbQzRub3QbAXFPvDB//+RS3
         TKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nNiF/cfpv32eI7WiEbUPrw8St0XMYF92yshDZXr8h2E=;
        b=BfEX0yz1eHhDU0iLxncZ1WGVdswRnp2il5oWTnQwOJndzFJOt06S6qQISnScwT3H5x
         AWWA2jGvH5TzlaokKN4XrNfFpHCtO6I0eexbQ2EnI4JAmcV2nTuFZlEW04Is9ZAWqugi
         Hd+K6JfuD1xOo9YQoQ1XMBju62lXPwP7WGe048naWfTwmx20voHxvWst4KraL4cMAUq1
         mFBEbl82sCXzw+bNPzeBIUXRL/9SrovrKDHygZIMBFgtna31YmpWNPWxRpE5mJ8rUP2l
         MXKYqE7TyPIcgdHVYWTxrNnDgFPfd/oDOORMvB/sWl7hUBNBb2iIE2kiZ33ADFoycukf
         HOPQ==
X-Gm-Message-State: AOAM532+GjgI8Ti7ktqRNnqREorBwMW/S6YNxavTzRBEeHmP+NnmZahY
        PHWYkU4yTAX0QWtkeqmXg50qnUWUEP/SsTZIUbs=
X-Google-Smtp-Source: ABdhPJxEgLCiIVnR5VqRo6eBDfNlBcoasPL30Nm2mNVMG5vS0YHNYgsnUiOWs7RVy5hmtXWxN+ilQ9zLWGyYeSaQOK8=
X-Received: by 2002:a1f:e643:0:b0:349:1f76:bd69 with SMTP id
 d64-20020a1fe643000000b003491f76bd69mr3549758vkh.10.1650319920889; Mon, 18
 Apr 2022 15:12:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:11c6:b0:29a:1d0:20c9 with HTTP; Mon, 18 Apr 2022
 15:12:00 -0700 (PDT)
From:   Mr Ahmad Fuad Elayyan <mrsleejenny1987@gmail.com>
Date:   Mon, 18 Apr 2022 23:12:00 +0100
Message-ID: <CAAhPbp_kp8v09J=1wdGKqAhUUfvpsx_uyPz-LDX=PJ=U0ak-mw@mail.gmail.com>
Subject: Attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attention,

I need your professional assistance to partner with me in the transfer
and investment of a huge Investment Capital for our mutual benefit.

Get back to me so I can give you details of my proposal.

Mr Ahmad Fuad Elayyan
Head of Central Operations

Ajman Bank U.A.E
