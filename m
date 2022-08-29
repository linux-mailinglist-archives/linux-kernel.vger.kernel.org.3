Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6535A4DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiH2NVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiH2NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:20:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F1886C19;
        Mon, 29 Aug 2022 06:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A5BBCE1232;
        Mon, 29 Aug 2022 13:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CAFC433D7;
        Mon, 29 Aug 2022 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661779067;
        bh=iU0NFuuW1JU52IzeEOR3wUWp/+GakMyFjikG9qQM6Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuIMTf3JLbwz5BVVP8K6H9Zs5in8kUbBe2dVUWSgB8mUZ5NYGFOfG4F/mMbc6Co73
         /aXpIbuKXv4Kfk6rsbaeqgE9EfnhiHrQGg8ulO9yACcEjMQ0LHPMYdGA1toKdKJ+5a
         2q4B272MrSLv+0XjrzJRdvgvCqov+kYkOvqLfBcY8E2laGNtNX0b0/iLnM2vrm9Uge
         hgeHT07BWTkrz4QJ1NLWEl6cnUDW+pGNtUhA0PD+Kq/l6QIWyPsavzBUZTIcT+xrX4
         8TZ7/hb+MRyH0VOjqv9Ci3LJd3ly6eAfI1q76X/CkGVaVVsOb4U2yaFw+WtJJebHIH
         oVRDaE8kAbhuQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oSeeI-00006d-Ud; Mon, 29 Aug 2022 15:17:55 +0200
Date:   Mon, 29 Aug 2022 15:17:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EM060K modem
Message-ID: <Ywy8gkqA9VCl0dRu@hovoldconsulting.com>
References: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:28:00PM +0800, Yonglin Tan wrote:
> Add usb product id entry for the Quectel EM060K module.
> 
> "MBIM mode": DIAG + NMEA + AT + MODEM + MBIM

> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>

Now applied with an added comment about the QDSS interface and the
id-entries sorted.

Johan
