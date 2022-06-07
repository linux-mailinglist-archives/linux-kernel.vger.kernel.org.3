Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22953F31C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiFGAzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiFGAzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:55:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E8BF11F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FCE360CA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957C7C385A9;
        Tue,  7 Jun 2022 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654563302;
        bh=jtKsJm2olsnz+fSzwZA/FF+z6PxvCo6g3U8AJ3kGynE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdPGdlgzYiEn6KC2AY89fd68QPepy/PmCePcArDAR197Fu4nhi5to+B+AotpYGp6/
         1sxB9O5X63W/A9frKCX80S6mag2QAVc1LidUtdVjy75JM4KpA2TzECJIlL308L+yII
         pl7Etz5KCN6TEQSkXaaL/9pVVOGhhJIS8Jywlynn6aNRQDtijVa0nSiaWzTT62g6Ov
         +gORgEC6JLBO6qLTdYIghUPZfopikSeZ0XCrpukJPOeWCsG1piMmRiLVU9yURawggp
         OLAHNyOduoS8uYiMQnn3KprJ8dAdlZpQH7bJ3w48nQK5oY8/kg+1b8cfE+POF100cJ
         7Iam57ewpGuuw==
Date:   Tue, 7 Jun 2022 00:54:59 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/13] platform/chrome: cros_ec_proto: separate
 fill_protocol_info()
Message-ID: <Yp6h4/BiVtWZ19nH@google.com>
References: <20220606141051.285823-1-tzungbi@kernel.org>
 <20220606141051.285823-8-tzungbi@kernel.org>
 <CABXOdTfNMpDUBpLVxiV1+B7M4jmG9998rC5WmrJvbuijXaGwBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTfNMpDUBpLVxiV1+B7M4jmG9998rC5WmrJvbuijXaGwBA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:06:03AM -0700, Guenter Roeck wrote:
> On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > -static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
> > -                                           int devidx,
> > -                                           struct cros_ec_command *msg)
> > +static int fill_protocol_info(struct cros_ec_device *ec_dev, int devidx)
> 
> I would suggest to keep the cros_ec_ prefix. Also, "fill" sounds a bit
> too much as if the function would fill some structure fields. "get"
> (ie cros_ec_get_proto_info or similar) might be a better name,

Ack, will fix in next version.
