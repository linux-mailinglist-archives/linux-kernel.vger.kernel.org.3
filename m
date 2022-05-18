Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD952C004
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbiERQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiERQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:28:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416021F6392
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:28:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f9so4956424ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2T+/PPPf7+3b/P3u/Ojh1mw+Ir4CRwarSeghbRqZSCk=;
        b=QuThysBNWbtYdQLwKisRzSxHxXH2bzmhew7tpYNn0YQij0/qm5bugUhw1P0L0CuRQW
         c5VhBk8AjuJ0fbt2Rb4VLeJiSzpr7dHyYjrGSKUvAmIX8AGcGAmATXyYqmxGKvERkTNp
         +DgB9wEfUYQWynFiTPs9Bw6eureGsDCgSW+inCCV2CjbhYph0jM645LG3EL6UakYEPu6
         i2J9N47cWHmb5rAy8b2URfuXo3EnkMBK/V3N/fMlpLoziPPV6h8MjLfjzRaK4qbbTUeW
         F3dz/Ys5Fl00cjXwavdGR+nhonhP8upRA85Ze7/GEtSs5iS0O+1a5jF6GeXQKOaRbwUv
         HQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2T+/PPPf7+3b/P3u/Ojh1mw+Ir4CRwarSeghbRqZSCk=;
        b=Zx7ifzygV0ueGKbJY5SdBhJmD5gb/II1qFyu0fq3vaV7NVRPH7GRDNlFUVvcGHCyhc
         JZaexsE9tOgU/QLRrSu8fw6oeXnumbWb4KU3wrOIaZTL7qjnwqwnPlqW/rXbsUSHafok
         Njn8J//DrPxiELBiiSMSh/HibwhzkX1lsGsmCn3NiwS8Eb/XuNHznboi6RTOTmEbRGS5
         4L+9FM5yOtGopBSzPh22zmJKItFDFgZ7e1JPTf+0aUDNzpUwRPk26g852uzxttBcY7hh
         BUulN4gK1zGx5ZC39rQ3shBo+pey+Hz3Rs1g4mOcPWMVMprpEh853KhOAsPjFk137Ghs
         ERtw==
X-Gm-Message-State: AOAM530vcizxAcXEvqBP1EJ9V+Nv7K8oDnRw5LF8g1BjOUNbC9ce5vy1
        bb/spNiKAqA4qu8Y9+xI6o7Efzczk1+bzGfXg6rePg==
X-Google-Smtp-Source: ABdhPJwfTAyvrsh1V2tpQziGWOESnnWRABmgdgov0Bjz1bFQmUI/Ipdka8Fnsrwfv3vc5GdV65SWiZgMGi4hW4LezMo=
X-Received: by 2002:a17:907:9711:b0:6f4:6989:6afb with SMTP id
 jg17-20020a170907971100b006f469896afbmr397884ejc.618.1652891316548; Wed, 18
 May 2022 09:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220518091814.2028579-1-tzungbi@kernel.org> <20220518091814.2028579-4-tzungbi@kernel.org>
In-Reply-To: <20220518091814.2028579-4-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 18 May 2022 09:28:25 -0700
Message-ID: <CABXOdTfHKgj+c4oA-EaVqRjaNmFn4i_GDEpEqdexvV0L=dNmXg@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_proto: update
 cros_ec_check_result() comment
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 2:18 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> At first glance, cros_ec_check_result() is quite like cros_ec_map_error().
> They check for `ec_msg->result` and return corresponding errors.  However,
> as calling from `pkt_xfer` and `cmd_xfer`, cros_ec_check_result() should
> not report furthermore errors.  -EAGAIN is the only exception.
>
> See [1][2][3] for some known userland programs' code.  The return code
> from ioctl only denotes the EC communication status.  Userland programs
> would further analyze the `result` in struct cros_ec_command* for
> follow-up actions (e.g. [4]).
>
> To clarify, update the function comment.
>
> [1]: https://crrev.com/54400e93a75ef440a83d6eaac2cec066daf99cf0/util/comm-dev.c#154
> [2]: https://crrev.com/fe32670a89bf59e1aff84bba9dd3295657b85e9b/cros_ec_dev.c#296
> [3]: https://crrev.com/4e19eb1d89de0422ff1bbd3f7260b131c761098c/drivers/google/cros_ec_dev.c#120
> [4]: https://crrev.com/54400e93a75ef440a83d6eaac2cec066daf99cf0/util/comm-dev.c#164
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from previous version:
> (https://patchwork.kernel.org/project/chrome-platform/patch/20220517082817.1591526-1-tzungbi@kernel.org/)
> - Update the link of [3].

The patch should be marked as v2 if there is a previous version. Other
than that,

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
>  drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 01ab58b3269b..13ced9d2dd71 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -204,9 +204,12 @@ EXPORT_SYMBOL(cros_ec_prepare_tx);
>   * @msg: Message to check.
>   *
>   * This is used by ChromeOS EC drivers to check the ec_msg->result for
> - * errors and to warn about them.
> + * EC_RES_IN_PROGRESS and to warn about them.
>   *
> - * Return: 0 on success or negative error code.
> + * The function should not check for furthermore error codes.  Otherwise,
> + * it would break the ABI.
> + *
> + * Return: -EAGAIN if ec_msg->result == EC_RES_IN_PROGRESS.  Otherwise, 0.
>   */
>  int cros_ec_check_result(struct cros_ec_device *ec_dev,
>                          struct cros_ec_command *msg)
> --
> 2.36.0.550.gb090851708-goog
>
