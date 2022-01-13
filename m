Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64CD48D9C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiAMOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235711AbiAMOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642084581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgjOVeBDkVjVu0DqCL0W103eS8yEjSifpQfplyuzn/Y=;
        b=C6AMoAJ++bbJukIIgXarjgKgt+SQiDuY2zunoOpdc/aHvHVxhi/egTrMr7Cp10yPYFD3u9
        JfIg7fylWpgiA2NpNCvJC44RPsxxsQx5qy84m6ge8WwIV7byfYVECfl3GuIaauE0o82afv
        WV22IMncmPAwyGbyWD6FSD8/DfJm0Qs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-2pMctT0iM12yXY7kDNd_aA-1; Thu, 13 Jan 2022 09:36:20 -0500
X-MC-Unique: 2pMctT0iM12yXY7kDNd_aA-1
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a056402520700b003f841380832so5531308edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 06:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IgjOVeBDkVjVu0DqCL0W103eS8yEjSifpQfplyuzn/Y=;
        b=8A8CZUNlqZFqkEI87qQozjzptm+Hqgsw+TTh+DNv/JHOKTCH6h9qlUqspItsUEvIqr
         aV5VmyahsUDLlzYVDPhnX3m6H3fBFYJ52MFgIHE6fBdQ63tj32dcyjYeybPoOPrQJa1u
         qGdge5NslRjY3z7cdvr2wL9XliogKqokn7uWCrnUIyssBwlfUi8uu3Vfv39QUHID8HZl
         9X+qhyTS9F/ZZCuAdEnVMO1HHQfCxBvrtKTeJffnUBeC97eHpig37wcm14TvOLhN33P/
         vApcncKNmRd1JgAN1iyc9/ZgbPaVhQu+QRTjMhxizVGDYnyLV9QXlyK+LzNHtqPeSOOG
         5zCw==
X-Gm-Message-State: AOAM533ttMjrJRTikbR1jVl0i7k5bZaWyVqrH5vfubT5cOYjHWuTIOb3
        1wnm7SU+2eKA9gdxdRR7qyW+AC8gDJIOzlJ2fYVKY0AtwKpNYryAFPvBheVvb79sGwWH6Yu6lG1
        m8S9r3RZ+YYTcPpLYudstQ3iH
X-Received: by 2002:a17:907:6e0c:: with SMTP id sd12mr3795826ejc.536.1642084578972;
        Thu, 13 Jan 2022 06:36:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOD4ZuNaqfWJsHOyQAzWBVTLHAz0c77AXhRgw1f3/AHOJfF9Qynw12hmuu+NaWD8zPJOqGKw==
X-Received: by 2002:a17:907:6e0c:: with SMTP id sd12mr3795799ejc.536.1642084578695;
        Thu, 13 Jan 2022 06:36:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id gb35sm941164ejc.36.2022.01.13.06.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 06:36:17 -0800 (PST)
Message-ID: <bdad7add-408f-e649-c796-6f83420077fc@redhat.com>
Date:   Thu, 13 Jan 2022 15:36:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: KVM: Warn if mark_page_dirty() is called without an active vCPU
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     butterflyhuangxx@gmail.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <e8f40b8765f2feefb653d8a67e487818f66581aa.camel@infradead.org>
 <20220113120609.736701-1-borntraeger@linux.ibm.com>
 <e9e5521d-21e5-8f6f-902c-17b0516b9839@redhat.com>
 <b6d9785d769f98da0b057fac643b0f088e346a94.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <b6d9785d769f98da0b057fac643b0f088e346a94.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 13:30, David Woodhouse wrote:
> Are you proposing that as an officially documented part of the already
> horrid API, or a temporary measure:)

Hopefully temporary, but honestly you never know how these things go.

Paolo

