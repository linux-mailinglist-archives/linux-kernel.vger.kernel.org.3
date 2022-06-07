Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4253F31E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiFGAzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiFGAzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C655BF887
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1F460ECA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4715FC34119;
        Tue,  7 Jun 2022 00:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654563315;
        bh=mEAGnwqSmfFEQzXLnJQtDlQVJh1cDCMLRlxqEbnIyo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kX+959qyO9qA5XrWtm1eZuVeZ311W/2joLYgPAGSShygut4tzCKMraGVoXEH+6As7
         6RiS48u1jfapWrvE1rNv00+ipINysYMszqoWx39Hqs+7/7z0bSCUYIURqgQdcT/nhd
         wbAYBROahsqXPoQJ+LrPKaRVhWu+k75dOHbmAU435BTYzRl8yjV/rbIy9zg42PkUcf
         RZlBo2dOb9Q5wuGcCgv1SVDEllxKMwYOXtLdBes9Aqa7cMcZ0BBWjsD3Nglop/F8fp
         A3X81heSmiYVKLwAvSOFLDiJzRrZJeSb/TcBLFOh+5eY/Mq/xpFHwgBaVH5N3JYh5l
         9IzjVHF/iMaag==
Date:   Tue, 7 Jun 2022 00:55:12 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/13] platform/chrome: cros_ec_proto: separate
 fill_protocol_info_legacy()
Message-ID: <Yp6h8DCbfdodbdZB@google.com>
References: <20220606141051.285823-1-tzungbi@kernel.org>
 <20220606141051.285823-9-tzungbi@kernel.org>
 <CABXOdTcJiytvKpQhbka5cLySiM+_aUAS-k0COu+xteaAVKqttQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTcJiytvKpQhbka5cLySiM+_aUAS-k0COu+xteaAVKqttQ@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:06:35AM -0700, Guenter Roeck wrote:
> On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > Rename cros_ec_host_command_proto_query_v2() to
> > fill_protocol_info_legacy() and make it responsible for setting `ec_dev`
> 
> cros_ec_get_proto_info_legacy() ?

Ack, will fix in next version.
