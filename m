Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1053F320
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiFGAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiFGAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B46BF8A7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E42FF60CA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E935C385A9;
        Tue,  7 Jun 2022 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654563348;
        bh=dG3GW1vGg8v++u5TM2satet5+WF7Uolsw1Vi4gFMOK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/EyZVAAAfbn435Yp9DYxpg42vl3PLmflrXTLXcUdYpriW4g8hywcJIiXlZAgG/w1
         ydf4AvgcRJmG1xrdDiEj1/DbwngConfN43XnY+CEgsMOhh/EkdKcX5EXQkwZwU3Y3H
         TUNptZUn4Tp49g8Cq//vGokY08txFbaLKtHTO7f8NjqG4ptBcQt2aSPTq5fqEhXu0D
         v59USu98mlkqm2N8mrdnfbgu44SMtxEMFmZyEmoJ5bwpfVejynfG/sWDjyn1wSUYX7
         3Fcxa19FxFjD+AfqRZV7zbL2WSyVbDKdFRKR2EU3m3jyPyw+59g9IS0yY5rjx3XDKU
         4uVdc+DPEyENA==
Date:   Tue, 7 Jun 2022 00:55:45 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/13] platform/chrome: cros_ec_proto: arrange
 get_host_event_wake_mask()
Message-ID: <Yp6iEVf7Alkv00/b@google.com>
References: <20220606141051.285823-1-tzungbi@kernel.org>
 <20220606141051.285823-13-tzungbi@kernel.org>
 <CABXOdTe-9gu+mPZp+drKknJysoRS3krO_KSxTfO90+8i2ooWDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTe-9gu+mPZp+drKknJysoRS3krO_KSxTfO90+8i2ooWDw@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:18:57AM -0700, Guenter Roeck wrote:
> On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > - cros_ec_get_host_event_wake_mask() is a private (static) function.
> >   Rename it to get_host_event_wake_mask().
> >
> Same as before - I still prefer to have prefixes. Also, this is a bit
> of point-of-view thing, so I'd rather leave function names alone
> unless there is a good reason to change them. Otherwise we might end
> up with sequences of function-name-rename patches for no good reason
> besides someone mot liking the existing names.

Ack.
