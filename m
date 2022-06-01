Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676C53AAC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356031AbiFAQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356018AbiFAQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:12:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1C34654
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:12:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r71so2370881pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MVLrEwZ4p8ZiMLFIiGZ5MBCO2DCADZBwmIVkqey2RUc=;
        b=a456sQS6yzyqveCJT2jJJslPJsV5eYz4PeXNgBTecQw3nrYwwZVtO2Ii+MAJaR0IUR
         /Hyb5P6aI9HTgnqVICWEAhF5FbYfrIkBcAaEAAddUcde3YaZEOyhxlvzp91xkO87RSa3
         f8xsSmuM53q8e1EPuIIy/i5PH9PevEwLAbj5KmkL7/k2Z0ZNQTnPR4ZXucCoyeEvxkGs
         Z7wdnOiU6QJy2BPlJoAhAXttwHGi7y1P8HYa7HfsbAK2WdM5L/OezAmtfCF9XaQD+xf7
         SJKvT8AETJr17AIMyvbq6R38FlmmfWvk5dD/2NIOSp9wbwoR2UzSA3zRo+NZn9lbkVfu
         uSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MVLrEwZ4p8ZiMLFIiGZ5MBCO2DCADZBwmIVkqey2RUc=;
        b=aAku9srSfNHugw3MjQCbPPQGk3crD1L7SUJ7cNB9dkPCAxFJSqzgc51Z1I/qgTFAjh
         xo0PCIabGzkAm4nsWn6je7yXyMRuC3WuZSbptIVxyTqi7pOpVeTdHHY8uFF6ec9ls+n2
         MF4ao93pXpQFoYTL/4vPcoqoFx9wW5gZdXD9Yliyopr/lKwWGdl7u0dNFUmoQWFaqsog
         q3ybDa9NjlPkMla3aHoodDtoHzLV++6BBtHRIDW9C8FPEtkxsVseCskJO4pox3mN5udk
         tjN7oagPnG7t/DW40fuccfyG8ZtbKrQ0dYG3T1vxuWDSxbrdmhqoSrFqmQgSAnkxrkof
         PbAw==
X-Gm-Message-State: AOAM533PrCrCdL1BuY4gQtEuF607gD/6y6q3prXfoz+JH9tvaL1uJm2p
        4rpr7GG2S/+1DTvUMk3xiYECBi6TV+g9LtPj2/Y=
X-Google-Smtp-Source: ABdhPJwPcZvkjEPZNDcdP3cV6fKqX+GhFUL/lUzwi2B7kSVhNRuiq2TvvMfXtPkNiaBt+B55KDZ04SKKRvclR5FcmX8=
X-Received: by 2002:a62:8101:0:b0:51b:b859:7043 with SMTP id
 t1-20020a628101000000b0051bb8597043mr297745pfd.25.1654099951799; Wed, 01 Jun
 2022 09:12:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:b751:b0:2a1:349f:69f3 with HTTP; Wed, 1 Jun 2022
 09:12:31 -0700 (PDT)
Reply-To: mrschantelhermans@gmail.com
From:   Mrs Chantel Hermans <eliaspeterson2024@gmail.com>
Date:   Wed, 1 Jun 2022 09:12:31 -0700
Message-ID: <CACCA4VvMXsZyt6Pxo101CbVqxbtXzJ2+PdTdc4t=q5J8H7Ocmg@mail.gmail.com>
Subject: ATTENTION
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ATTENTION,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:532 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5118]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [eliaspeterson2024[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [eliaspeterson2024[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.5 SUBJ_ATTENTION ATTENTION in Subject
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
ATTENTION

You have been compensated with the sum of 1.7 million dollars in this
United Nation the payment will be issue into ATM Visa Card,

 and send to you from the Santander Bank of Spain we need your
Address,Passport and your whatsapp number.


THANKS
Mrs Chantel Hermans
