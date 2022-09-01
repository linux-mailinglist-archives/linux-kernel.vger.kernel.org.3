Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A25A8DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiIAF6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiIAF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:58:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B655611D925
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:57:46 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e7so7389041ilc.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wB71mxz9sZZ6MrmdLLN+L5oPjA7Db42fd3yvoP7ITlE=;
        b=j+6RvxtEzxfiZJ0UDAc2gOcGkw+uqI/fHvxwZRPA/yeDT/9+LAM2FKCYcpM3qzlM8p
         WVeYFURqEbCwWULAdBoQzm8/q+Rfh9N77Kt1TiUyZR4lwvo67VqtHUYWDXlEUnXvNA+6
         x36A4UWfqj7sGb4Nq9Yp8Bke2h1VGpTk0jTRwwDdZu8joaUwmUYvuhLU4WBqMHhSC9Au
         RJzwA582AIrJ5JettZNKAEvLa/F41Ftr3g8fl/KN5gySYEhTSmijWO8351pmtqMXBB02
         nX3DoKqj9TAl+ZDdTE/UunFi6XZUVmlazC16PiiQ9O6Cj2dEpk8qhVb0W9n/YCdeUTb4
         EegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wB71mxz9sZZ6MrmdLLN+L5oPjA7Db42fd3yvoP7ITlE=;
        b=Gp+XsDYGujbmdDKMb2PWLvJHj9zjE5CcAw7X3yxEn/4I9bG5YMUCz74lPJig0WUrIA
         qyxw0c+2n5N0vUv1sR5UPsQsDFYKCFNePnDAS5oH6YB4PGAFhOfO54ZUz32e8UgfWhqt
         3MBKJZBhHCzBHJpURTh1v+2ZVfQG68R6vO4MUZZYbwJVSqwn2rs3KrCuhp7ZUzYdWkk4
         VpGY4uGrbS++OMrYdFeHYw1ZWNgGqu5Hfa2xofcMRYFwWxOghAMXY9afu0EoQ2oT+zZK
         G/qkvd2M/QVnJhw8xA9uCTOlKwIJ46goLSLxl0QR6gUoG07Ljld3Yd/Us1atp0Ra7IMc
         Ef/g==
X-Gm-Message-State: ACgBeo0W3LJUeD+EbMEpGF5dfIgalWEOSiFjF0VRrsbbFYsWQKHqIJ9e
        S78Hf49HAWbS3gdPJe2pVQIgBhZ0jdteLNzZNFL9OChSk10=
X-Google-Smtp-Source: AA6agR6xefaf7USZwlxLIWwGM36QJLwI5omqHhij2aogBV5iiU+XyfDLWU4vSFCNsu66cWa2lzNQlpEszhPDJ1qoMUA=
X-Received: by 2002:a92:d5cf:0:b0:2e9:4cb4:57e4 with SMTP id
 d15-20020a92d5cf000000b002e94cb457e4mr15618513ilq.224.1662011852348; Wed, 31
 Aug 2022 22:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220826023504.6183-1-steve.lee.analog@gmail.com> <Yw+OCnOgYUOWdIEx@sirena.org.uk>
In-Reply-To: <Yw+OCnOgYUOWdIEx@sirena.org.uk>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Thu, 1 Sep 2022 14:57:19 +0900
Message-ID: <CA+Fz0PZStYOZhNpRQCCVKxaDmPPq_PwvWrxfWbq=sBNKrZzzNg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98390: Remove unnecessary amp on/off conrtol
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        krzk@kernel.org, ryans.lee@analog.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 1:36 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 26, 2022 at 11:35:04AM +0900, Steve Lee wrote:
>
> >  The Amp is already control in userspace before trigger calibrate function.
> > Remove unnecessary control in calibrate function.
>
> I can't see anything which ensures that this is the case?  Should there
> be a check which returns an error if the output is not enabled, or
> should the function check the current state and preserve it at the end?
> I can see that this would fix problems with it being disabled when
> callibrating.

 As your comment, this can fix amp being disabled when calibrating.
And this also fix the case that music play right after calibration.
Actually, calibration process should start mute playback before
trigger this function.
AMP disable/enable control in calibration function can break sync with
userspace enable/disable control.
