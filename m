Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFBC58809B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiHBRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiHBRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:00:09 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC94F15714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:00:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id y11so11148856qvn.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=xQ0kvl9C3hCLQpFuT6ogOJg1ypf6GITTlwjPXuv+0b0=;
        b=I2lVxFu0JMs77LdlkLS7pRzfNNzJjEY1Cn6T5H/Jab/W+7TquRmwlUkoo4Anj1xlb5
         PQQpBzbGCv+KhgyQSGPX3soU9L4SQObLGnG8+wqNvUlG9tuV/kvFyZpNwClOUvgaly/N
         bHyxk3tZZY5vWLeHO5xXmIDv+IP1KO8MtBksg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=xQ0kvl9C3hCLQpFuT6ogOJg1ypf6GITTlwjPXuv+0b0=;
        b=o2AId/z6MvUis+ezJ7G6gl0A+QcTNM9zXb2NTWOFjIPdbN3uIRPwDcEhBuPAhbv9CZ
         eptlO3uiEI/RO0y2LDszsqzYWT47wv0dlFIs2OG0VAmcX3hDFAXBiHOEkxOLvueCROg6
         Mg6KxTcT+701ZcDvdfBn9dzs0FhXZkA/h+N/b5XP7ih8IVo09EpZ8xTcj9gH/qg0+xUu
         EjMYau83y+idA0Yb7O1iunh4vYWg4C7g8HPVtPwGc28+cgOAGwz3LGQ9oMa0X3eMfS7+
         XDJja83AktdOYFekJukBqbmq+AIcXwoyDUasVhGV6P2V0Y5bvO1ymFWhpStZq5oxlxBw
         9JaA==
X-Gm-Message-State: ACgBeo0pXFesBEcXRIk8tBszTX2ZgcYdD+RnrzXCd6O/k078t3A8nu1W
        x2vXKkTtG6g7C3r4pMf9YfV7jA==
X-Google-Smtp-Source: AA6agR4VtP2gYy4PjhKLRngiYMERbRcMmBEW8EUJgR+UmvRBa63bq2GYROFZXyKXiceS95Bc+d/RaQ==
X-Received: by 2002:a05:6214:2466:b0:474:7d56:8f2d with SMTP id im6-20020a056214246600b004747d568f2dmr18813587qvb.90.1659459608011;
        Tue, 02 Aug 2022 10:00:08 -0700 (PDT)
Received: from nitro.local (host-142-67-156-76.public.eastlink.ca. [142.67.156.76])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a430500b006b5988b2ca8sm11478209qko.40.2022.08.02.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:00:07 -0700 (PDT)
Date:   Tue, 2 Aug 2022 13:00:05 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Update the maintainer PGP guide
Message-ID: <20220802170005.fpt3g5bk5i6ygqz2@nitro.local>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
 <YujpSWaISTWm8/8w@ada.ifak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YujpSWaISTWm8/8w@ada.ifak-system.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:07:21AM +0200, Alexander Dahl wrote:
> Hallo Konstantin,
> 
> Am Thu, Jul 28, 2022 at 04:57:03PM -0400 schrieb Konstantin Ryabitsev:
> > This series updates the guide to match terminology used in the upstream
> > "protecting code integrity" guide [1] and brings the documentation in
> > line with the latest developments in the GnuPG world:
> 
> I could not find [1]. Did you miss to add the footnote?

I did. I'll send a follow-up v2. The footnote was supposed to be to the
following URL:

[1]: https://github.com/lfit/itpol/blob/master/protecting-code-integrity.md

-K
