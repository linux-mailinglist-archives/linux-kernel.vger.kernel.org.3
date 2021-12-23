Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4395947E86F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350047AbhLWTlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbhLWTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:41:09 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768FC061401;
        Thu, 23 Dec 2021 11:41:09 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3B8F62D7;
        Thu, 23 Dec 2021 19:41:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B8F62D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640288468; bh=IImowtX5LGoKlTdhC5sVW1k4yjTfbWdEZ6Sx6l8h66c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BE+nBTLBJlZHz3eDjKHdi+zCE9WuYVkItmorb39cDwdZuTxEaSluTkTNEJAsy5YP+
         ZCmYiirXOwi6tG3Ic4m862gxk4iqj8RBpQI1A9Q5UCtg28B3MJ2cq2i2l+VPy6tqVN
         +PB4haPI73BbYi4PdsfKEZ0Y8uWwhZxw95vWtsq8ZYdCirAA1IunuQicloWbkM75iC
         W3BnORmPn6+82F5qqQy0YmowM/bNUN42u/gFeLUw3CtHE9Z3XwGMzLdwbVAWC2oi6V
         3VeaUDcJYTu9Yy2O0QgT4WjrDe8FyRbRZu29qYROtgUBoJ8X757rKb/1LuLeZNdqam
         QGKgQxPtQirZg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jens Axboe <axboe@kernel.dk>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-doc@vger.kernel.org, linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] doc: fs: remove bdev_try_to_free_page related doc
In-Reply-To: <b75b794d-8c06-bbef-fb12-bef8105f41db@kernel.dk>
References: <c45e6351-b0f8-3410-787e-02c6aeb3efe6@huawei.com>
 <b75b794d-8c06-bbef-fb12-bef8105f41db@kernel.dk>
Date:   Thu, 23 Dec 2021 12:41:07 -0700
Message-ID: <87h7azf6ss.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 12/22/21 8:51 PM, Zhiqiang Liu wrote:
>> 
>> In commit acc6100d3ffa ("fs: remove bdev_try_to_free_page callback"),
>> bdev_try_to_free_page has been removed.
>> 
>> We should remove its doc.
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>
> Jon, I'm assuming you'll take this one through the doc tree.

Applied, thanks.

jon
