Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BF246B818
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhLGJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhLGJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:56:35 -0500
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net [IPv6:2001:888:0:108::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE43C061574;
        Tue,  7 Dec 2021 01:53:04 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id uX9hmxuz0QyExuX9km6Mi2; Tue, 07 Dec 2021 10:53:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638870784; bh=EstFIXaPiRyN3kx9hm1aQnJe5UL/aOez14bDvEP3YPk=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From:
         Subject;
        b=ZYrzLQzZGFbNfLf4+4KFVI/PfKHp8ETnyrMW8tI8D8yekKsoAtAPYSPs6TQLM38re
         AsGjnrm7nFzwcJL0QT/yD3OIa0KwN8CE30GoTfFX+BQLPOZAep9z77gib1YadrrIng
         xtvazhczzR1dnLTOYYIC5aNTOCJ4s83opwrVmeg39lkT5EDUVQTMj6sMP7bOHC+We6
         pDFHEioxlrA08IWmwFsJ6++fKTV9DVhxlG88aeNNy51UOiKlQLU6dbD9wtURpm3IJk
         wP0H9inwBSts9sEZujv/Ob6l5JRLCnEXdw7Du8F5Y6YNdz+0T7v2fl52IeoImNnFSq
         Wi+TM6cYZUgLw==
Message-ID: <8942f489-6d02-8a3c-9c8d-1a4ef15e90fa@xs4all.nl>
Date:   Tue, 7 Dec 2021 10:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/4] media: Documentation/driver-api: Document entity
 name
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
References: <20211207003840.1212374-1-ribalda@chromium.org>
 <20211207003840.1212374-4-ribalda@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20211207003840.1212374-4-ribalda@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBu7utwmC6EGa7HKe7ke3QdQtZmAME2hu+u75WwHvFpHFKhXwD4fYqqRMfGrWBiurvSAMVKvrCl3QWAEH8yp3ZIfZQQFecMjiMM9UTuJ3oIzo+uWQbIN
 vFyl/B3jbB7AA/xTTm4FPY6wBuQdP1amK9hMShz1OSRjtcmJH4TzbcoZqM2NCSLa8LR4o4GatV/okVPS6r+yimUePr8pwX868YWDawKddfAgIBjRrMEytFjf
 s6eMEIcwfD/zeD33G9X5sRcLT5imNtl7O7xbS+LsW/14LqghRP0UAIlamobgwW4H4KGWPpKuZcgMHC/CAgBzPy3VPI+ZdsQRMz123wg5rav+Y3papHH9nDWz
 nLvUk8nFGPOKY1YRKFvvLtI5p8MKDDDn5xRM3Tpnyj8pzoDRUtitDdJwICvOTNw4xjQXL6P1Bd/z5VQLElBy81yFXs4saU/T1bsjLoqhrDOK3vyetgI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 01:38, Ricardo Ribalda wrote:
> Now the entity name can be configured by the driver to a value different
> than vdev->name. Document it accordingly.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  Documentation/driver-api/media/v4l2-dev.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/driver-api/media/v4l2-dev.rst b/Documentation/driver-api/media/v4l2-dev.rst
> index 99e3b5fa7444..22120b60b0a9 100644
> --- a/Documentation/driver-api/media/v4l2-dev.rst
> +++ b/Documentation/driver-api/media/v4l2-dev.rst
> @@ -134,6 +134,10 @@ manually set the struct media_entity type and name fields.
>  A reference to the entity will be automatically acquired/released when the
>  video device is opened/closed.
>  
> +The entity name can be configured by setting the `vdev->entity.name` pointer
> +to the desired value. If it is set to NULL, the entity will be named as the
> +video device.
> +
>  ioctls and locking
>  ------------------
>  
> 

