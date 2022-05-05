Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA551BE16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357648AbiEELg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiEELgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCF26138;
        Thu,  5 May 2022 04:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3780C61CE6;
        Thu,  5 May 2022 11:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E54C385A8;
        Thu,  5 May 2022 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651750358;
        bh=9cDbNf09rQ+Fh9jlEqUCaVri7Zk3GBsAtBNRp7sG2OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNKCUsR2iT1jW0FILPqqa3cFRojFZqI23EQgfa/KOomVgcY04U9wzMtKWlOFlEVL9
         HYtQB2Q5BDLtkBwBC79a8uYyQDJ/e6fqfPBlL0kZH03XmOMInC81IBTGneK+zEJNVs
         38Qyt23w+FSmMc8GI+O5Kyp/k62mkhjyUdy6dG3MF++Cwh0mNK/vZyY6ZDhKL2D9C0
         Auc6Rf1431DRjwrn4J2Jg5wrVaiwzYLWDNFk7LeOon/r8g5+D/T2g+J6cTTWVtrVC2
         2ojnhVSr5NuP+/1IAppQ9ZiIXwIKL5y7njDuDu8o3M3fMAL7+/aIv8J/P1yDnMNVTF
         e1Hqw6cwJlwAQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nmZip-0002uA-0U; Thu, 05 May 2022 13:32:39 +0200
Date:   Thu, 5 May 2022 13:32:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, roger@labau.com.tw,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: pl2303: add device id for HP LM930
 Display
Message-ID: <YnO11yU7QQYH45i0@hovoldconsulting.com>
References: <20220425090020.33683-1-scott@labau.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425090020.33683-1-scott@labau.com.tw>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 05:00:20PM +0800, Scott Chen wrote:
> Add the device id for the HPLM930Display which is a PL2303GC based device

Thanks for including the chip type in the commit message.

> Signed-off-by: Scott Chen <scott@labau.com.tw>
> ---
>  Changes in v2:
>   - Product id uses tab instead of spaces

Now applied.

Johan
