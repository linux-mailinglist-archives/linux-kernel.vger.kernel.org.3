Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326EC596A95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiHQHpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiHQHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:45:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FA79A64
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so23048296ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BITzr7eaqZDWN9J3zA+mBc+Jo1kRZ2EMV6/Z9lL2EMQ=;
        b=bNlWuLBs8GCE+7ka7N/s08dLf07u3ZpgF6mQfe5nOAgCOzRYF1JRf9t54QNz2jqsqn
         KwuyRypgQVtxQTG/gnPjXua7x5Zmtj4DkrRHPB+W3Ruouj8crgEyFAWKU/UFYHZrevqA
         Tu9pda1MWmQ/eDmBcbEHzDgTJNQp0c84vsVXvHmJ6Y9t+YFnFN+lAr13Urjn2JWDf8Gy
         s8Xx4rsCIkByg5O+cw/L4opxTjI1b2Rktbx4jPzNk2P1vCEjlTQbZNJOtJY1WeBlLvRE
         dzzFGq8BsrEKf+tTrAezQTWoo9LEHzXzTc0YMcKI8FmV00ECzItPEy22A3C/idOhp5o3
         2oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BITzr7eaqZDWN9J3zA+mBc+Jo1kRZ2EMV6/Z9lL2EMQ=;
        b=51Q24hjSTo4IGrs5cb1d1CXIVnowW+zryoVqNXb1Mgjj4Xm9CyFzG6AzC1i6nDtaqM
         iTAFqHwBYF31uosU6iQVKpgHp6uyW692IkwAQkpttAodSLAADoNzA2pE+OF4LLnFFOJO
         9Axv76n1T6Nrt88x6uNi7sWatXYUMV54Rv1DhdSfu+PvT6bzaraJEZ9WZIzGdRtBv+C2
         RrWn9UdymWySgUvRrt2pEXzOWv8a1VHEG0VhlL1641mOBq3pEMuzAScF1KA/MjmsAdVV
         1/+emXwfuI+jmn8FUdpYrRU3VfqTAktqyoeaYmS+LhBApViSlmeEkJlR11j/d2E8R/yr
         QlRQ==
X-Gm-Message-State: ACgBeo3gQcrUHoeI7IQ+6JVayH8rGutRYRc7xdD10nArn44KeS54WAPn
        ffLqdw0DdvYpvu6KSHCN+iydplYyl1Q=
X-Google-Smtp-Source: AA6agR6E+6b2jXdoxvTMntgNL9Lk462Bgvhl6B0xPBHN/SLGgjJO8H2pdr8kZsJxlsyjUGCcZGDeig==
X-Received: by 2002:a17:907:b590:b0:730:9e03:95a8 with SMTP id qx16-20020a170907b59000b007309e0395a8mr15776875ejc.384.1660722311547;
        Wed, 17 Aug 2022 00:45:11 -0700 (PDT)
Received: from agape.jhs ([5.171.72.69])
        by smtp.gmail.com with ESMTPSA id o10-20020a056402038a00b0043a7134b381sm10052533edv.11.2022.08.17.00.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:45:10 -0700 (PDT)
Date:   Wed, 17 Aug 2022 09:45:07 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Simone Serra <serrazimone@gmail.com>
Cc:     gregkh@linuxfoundation.org, soumya.negi97@gmail.com,
        hdegoede@redhat.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes compilation errors after checkpatch warnings
Message-ID: <YvycgyjCwKlsp318@agape.jhs>
References: <20220809143743.742636-1-serrazimone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809143743.742636-1-serrazimone@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simone,

On Tue, Aug 09, 2022 at 04:37:43PM +0200, Simone Serra wrote:
> This patch fixes compilation errors produced by the previous commit that resolved a number of checkpatch warnings and errors
> 

thanks for your patches. Try to focus on a single checkpatch error
and send a patchset for that one. This makes review easier.

It is a good thing for a patch to fix one thing and to have a proper
commit message describing what the patch is meant to fix. Don't be too
generic.

Always compile test your patches, before submitting!

Thank you,

fabio
