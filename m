Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26A4CB1B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbiCBWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiCBWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:05:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23CDC992D;
        Wed,  2 Mar 2022 14:04:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id u16so3081038pfg.12;
        Wed, 02 Mar 2022 14:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vBbzqL5wzXDyYewKK9YMLC34hfMZMISsP5DKji4BCmA=;
        b=RusE2PCgcFMfdKKim3gWHJLEn0607dTkVampVLsN1xn9JkifVakSEZTZ4Fh+iJqm4T
         FoyEwSCoemDQDoEkLVvfiYETQXXn1I2d0mKG/futFc2g8P5EZDHmncUZex3ff7VH8IRi
         tJoui5HpHjfqVlj9zlKpTRTF58kQoBd1rqujKbKgNGYo92y1wnhxOVHZfLzBTBuESso3
         bz4wQrMQ1TkSOZU6sReOVKiuoTeu8oC1pUwoYn1kKiremw8PhZ0PEp2NQRXstNLOi0DK
         aH3l5OYhubb7SjTGZhXCP1bdSDO0Pnz9rPALQgNapYJXhP+RXbpjCpn89oqWQLx8JgiB
         Vwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vBbzqL5wzXDyYewKK9YMLC34hfMZMISsP5DKji4BCmA=;
        b=FZIQtEKQwZnnAP10o9WHGlwYAW9WOYiCgw6Z5/mUnl6iDoRJsRUMcD+5pnmTCpP/kF
         VzwxUhrByW5s+cCw4sNr4fjbPhlEls7URkPHrLBAW9yx9rEhq25qyJTmysl5pnVtPqr3
         ksREFP3fKjJq194WConehnIKYAndPHZVYdtNyXwjsHcqFvJZUBZaD9GACG+IhAm5OAqH
         WACkHQsAtPA1SK1WYqX/9zcu7dGWd8IIvpKBU8BJj3X0GZt/5fZ4aArDeXXSmcL4Kbay
         ZqxsSwuqw2t9dGsFuy//b4U7fwGocXq/t/JGA8jeqjegQWYtyyBkfv/nlOuRbd8J66O0
         HJZA==
X-Gm-Message-State: AOAM533pY2lRfssbFaZz0xTRtI3VaKsyWYEto19Uvc/R5b4uZLEhnpK0
        CGt7mHuxJhplF8qNvxXoBE8=
X-Google-Smtp-Source: ABdhPJzBawCCDj6DACutvBz+CF09wvWCPc2LPZ2M+2c/U341UijhRcpLO4Eq8QSmRI0cXlQgii98hg==
X-Received: by 2002:a63:5d0a:0:b0:377:1ad7:5be1 with SMTP id r10-20020a635d0a000000b003771ad75be1mr23721319pgb.576.1646258673997;
        Wed, 02 Mar 2022 14:04:33 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f1fc:2949:1f18:b6ff])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm130304pgs.6.2022.03.02.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:04:33 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:04:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     William Mahon <wmahon@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: Add mapping for KEY_DICTATE
Message-ID: <Yh/p7qOHh3cqANMf@google.com>
References: <20220218215531.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218215531.1.I5dbf50eb1a7a6734ee727bda4a8573358c6d3ec0@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On Fri, Feb 18, 2022 at 09:59:08PM +0000, William Mahon wrote:
> Numerous keyboards are adding dictate keys which allows for text
> messages to be dictated by a microphone.
> 
> This patch adds a new key definition KEY_DICTATE and maps 0x0c/0x0d8
> usage code to this new keycode. Additionally hid-debug is adjusted to
> recognize this new usage code as well.
> 
> Signed-off-by: William Mahon <wmahon@google.com>

Was about to apply but scripts are complaining about difference between
from and signed-of-by addresses. Could you please make them match?

Thanks.

-- 
Dmitry
